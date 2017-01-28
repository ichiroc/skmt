# coding: utf-8
require 'rails_helper'

RSpec.describe Product, type: :model do
  subject(:product) { build :product }
  it '有効なファクトリを持つこと' do
    expect(build :product).to be_valid
  end
  it '0円の場合は無効であること' do
    product.price = 0
    expect(product).not_to be_valid
  end

  it '値段は必須であること' do
    product.price = nil
    expect(product).not_to be_valid
  end
  it '名前は必須であること' do
    product.title = nil
    expect(product).not_to be_valid
  end
end
