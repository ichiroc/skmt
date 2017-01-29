# coding: utf-8
require 'rails_helper'

RSpec.describe CartItem, type: :model do
  subject(:cart_item) { build :cart_item }
  it { is_expected.to be_valid }
  it '数量は1以上であること' do
    cart_item.quantity = 0
    cart_item.valid?
    expect(cart_item.errors[:quantity]).to include 'must be greater than 0'
  end

  it '商品の合計金額を出せること'

end
