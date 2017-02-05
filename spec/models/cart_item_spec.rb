# coding: utf-8
# frozen_string_literal: true
require 'rails_helper'

RSpec.describe CartItem, type: :model do
  subject(:cart_item) { build :cart_item }
  it { is_expected.to be_valid }
  it '数量は1以上であること' do
    cart_item.quantity = 0
    cart_item.valid?
    expect(cart_item.errors[:quantity]).to include t('errors.messages.greater_than',count: 0)
  end

  it '商品の合計金額を出せること' do
    cart_item.quantity = 10
    expect(cart_item.total).to eq cart_item.product.price * 10
  end
end
