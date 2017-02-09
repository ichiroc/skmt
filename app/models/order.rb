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
  enum delivery_time_zone: { nothing:   0,
                        zone8_12:  1,
                        zone12_14: 2,
                        zone14_16: 3,
                        zone16_18: 4,
                        zone18_20: 5,
                        zone20_21: 6 }
  before_save :copy_from_cart, unless: ->(){ cart.blank? }
  validates :total, presence: true, numericality: { greater_than: 0}
  validates :delivery_time_zone, presence: true
  validates :destination_name, presence: true
  validates :destination_zip_code, presence: true, format: {with: /\d{7}/}
  validates :destination_address, presence: true

  before_validation :regulate_zip_code

  private

  def regulate_zip_code

  end

  def copy_from_cart
    self.user = cart.user
    self.total = cart.total
    self.tax_amount = cart.tax_amount
    self.delivery_fee = cart.delivery_fee
    self.cache_on_delivery_fee = cart.cache_on_delivery_fee
  end
end
