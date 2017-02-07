# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  price       :integer
#  status      :integer          default(0)
#  sort_order  :integer          default(100)
#  image       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Product < ApplicationRecord
  mount_uploader :image, ProductImageUploader
  validates :price, numericality: { greater_than: 0 }, presence: true
  validates :sort_order, numericality: { greater_than_or_equal_to: 0 }, presence: true
  validates :name, presence: true
  enum status: { active: 0, hidden: 1 }
  paginates_per 10
end
