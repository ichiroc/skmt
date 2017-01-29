# coding: utf-8
require 'rails_helper'

RSpec.describe Cart, type: :model do
  subject(:cart) { build :cart }

  it { is_expected.to be_valid }

  it 'ユーザーに紐付いていないで保存するとエラーになること' do
    cart.user = nil
    cart.valid?
    expect(cart.errors[:user]).to include 'must exist'
  end

  it 'カートに商品を追加出来ること' do
    expect{
      cart.items << build(:cart_item)
      cart.save
    }.to change(cart.items, :count).by(+1)
  end

  it 'カート内の商品の合計金額を計算できること' do
    items = 10.times.map{ build :cart_item }
    cart.items = items
    expect(cart.total).to eq items.map(&:total).inject(:+)
    # 念のため
    cart.items = []
    i1 = build :cart_item
    i2 = build :cart_item
    cart.items << i1
    cart.items << i2
    expect(cart.total).to eq i1.total + i2.total
  end
end
