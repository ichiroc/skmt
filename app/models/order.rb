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
#  delivery_time_zone    :integer
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
  belongs_to :user
  has_many :items, class_name: OrderItem, dependent: :destroy
  enum delivery_time_zone: { unspecified:   0,
                             zone8_12:  1,
                             zone12_14: 2,
                             zone14_16: 3,
                             zone16_18: 4,
                             zone18_20: 5,
                             zone20_21: 6 }

  validates :total, presence: true, numericality: { greater_than: 0 }
  validates :delivery_time_zone, presence: true
  validates :destination_name, presence: true
  validates :destination_zip_code, presence: true, format: { with: /\A\d{7}\Z/ }
  validates :destination_address, presence: true

  after_save :empty_cart!
  before_validation :format_zip_code, unless: -> { destination_zip_code.blank? }

  def subtotal
    items.map(&:total).inject(:+)
  end

  def copy_data_from_cart!
    self.user = cart.user
    self.total = cart.total
    self.tax_amount = cart.tax_amount
    self.delivery_fee = cart.delivery_fee
    self.cache_on_delivery_fee = cart.cache_on_delivery_fee
    self.items = cart.items.map { |ci|
      oi = items.build(cart_item: ci)
      oi.copy_data_from_cart_item!
    }
    self
  end

  def set_default_destination!
    self.destination_address = user.address
    self.destination_zip_code = user.zip_code
    self.destination_name = user.name
  end

  private

  def empty_cart!
    cart.empty!
  end

  def format_zip_code
    self.destination_zip_code = destination_zip_code.delete('-').strip
  end
end
