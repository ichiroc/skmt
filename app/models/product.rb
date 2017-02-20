# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  price       :integer
#  status      :integer          default("active")
#  sort_order  :integer          default(100)
#  image       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Product < ApplicationRecord
  mount_uploader :image, ProductImageUploader
  has_many :cart_items, dependent: :destroy
  has_many :order_items

  scope :sorted, -> { order(:sort_order) }

  enum status: { active: 0, hidden: 1 }

  validates :price, numericality: { greater_than: 0 }, presence: true
  validates :sort_order, numericality: { greater_than_or_equal_to: 0 }, presence: true
  validates :name, presence: true

  paginates_per 10
end
