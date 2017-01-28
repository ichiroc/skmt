# coding: utf-8
require 'rails_helper'

RSpec.describe Cart, type: :model do
  it '有効なカートがある' do
    expect( build :cart ).to be_valid
  end
  it 'ユーザーに紐付いていること'
  it 'ユーザーに紐付いていないで保存するとエラーになること'
  it 'カートに商品を追加出来ること'
  it 'カート内の商品の合計金額を計算できること'
end
