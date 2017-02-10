# coding: utf-8
require 'rails_helper'

RSpec.describe Order, type: :model do
  subject(:order) { build :order }
  it { is_expected.to be_valid }
  it '注文品目から小計を計算できる'
  it 'カートから注文情報を生成できる'
  it '配達時間帯は必須'
  it '配達先氏名は必須'
  it '配達先郵便番号は必須'
  it '配達先郵便番号は7桁の数字'
  it '配達先郵便番号にハイフンが含まれていたら除去する'
  it '配達先住所は必須'
end
