# coding: utf-8
# frozen_string_literal: true
# == Schema Information
#
# Table name: orders
#
#  id                    :integer          not null, primary key
#  user_id               :integer
#  total                 :integer
#  tax_amount            :integer
#  delivery_fee          :integer
#  cache_on_delivery_fee :integer
#  delivery_time_slot    :integer          default("unspecified")
#  delivery_date         :date
#  destination_name      :string
#  destination_zip_code  :string
#  destination_address   :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
# Indexes
#
#  index_orders_on_user_id  (user_id)
#

class Order < ApplicationRecord
  attr_accessor :cart
  attr_accessor :remember_destination
  belongs_to :user
  has_many :items, class_name: OrderItem, dependent: :destroy
  enum delivery_time_slot: { anytime:   0,
                             between_8_and_12:  1,
                             between_12_and_14: 2,
                             between_14_and_16: 3,
                             between_16_and_18: 4,
                             between_18_and_20: 5,
                             between_20_and_21: 6 }

  validates :total, presence: true, numericality: { greater_than: 0 }
  validates :delivery_time_slot, presence: true
  validates :destination_name, presence: true
  validates :destination_zip_code, presence: true, format: { with: /\A\d{7}\Z/ }
  validates :destination_address, presence: true

  after_initialize :set_cart_data!, if: -> { new_record? && cart }

  before_validation :format_zip_code, unless: -> { destination_zip_code.blank? }

  before_save :save_destination_to_user!, if: -> { remember_destination }
  after_save :empty_cart!, if: -> { cart }

  def subtotal
    items.map(&:total).inject(:+)
  end

  private

  def save_destination_to_user!
    user.name = destination_name
    user.zip_code = destination_zip_code
    user.address = destination_address
    user.save!
    self
  end

  def set_cart_data!
    self.user                  = cart.user
    self.total                 = cart.total
    self.tax_amount            = cart.tax_amount
    self.delivery_fee          = cart.delivery_fee
    self.cache_on_delivery_fee = cart.cache_on_delivery_fee
    self.destination_address   = cart.user.address  if destination_address.blank?
    self.destination_zip_code  = cart.user.zip_code if destination_zip_code.blank?
    self.destination_name      = user.name          if destination_name.blank?
    cart.items.each do |ci|
      self.items.build(cart_item: ci)
    end
    self
  end

  def empty_cart!
    cart.empty!
  end

  def format_zip_code
    self.destination_zip_code = destination_zip_code.delete('-').strip
  end
end
