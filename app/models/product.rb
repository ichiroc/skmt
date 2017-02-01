# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  price       :integer
#  hidden      :integer
#  sort_order  :integer
#  image       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Product < ApplicationRecord
  mount_uploader :image, ProductImageUploader
  validates :price, numericality: { greater_than: 0 }, presence: true
  validates :sort_order, numericality: { greater_than_or_equal_to: 0 }, presence: true
  validates :title, presence: true
end
