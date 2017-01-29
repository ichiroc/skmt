# coding: utf-8
require 'rails_helper'

RSpec.describe CartItem, type: :model do
  subject(:cart_item) { build :cart_item }
  it { is_expected.to be_valid }
  it '商品の合計金額を出せること'
  it '数量は1以上であること'
end
