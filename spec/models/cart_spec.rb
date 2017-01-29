# coding: utf-8
require 'rails_helper'

RSpec.describe Cart, type: :model do
  subject(:cart){ build :cart }
  it { is_expected.to be_valid }

  it 'ユーザーに紐付いていないで保存するとエラーになること' do
    cart.user = nil
    cart.valid?
    expect(cart.errors[:user]).to include 'must exist'
  end
  it 'カートに商品を追加出来ること'
  it 'カート内の商品の合計金額を計算できること'
end
