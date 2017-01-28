# coding: utf-8
require 'rails_helper'

RSpec.describe Product, type: :model do
  it '有効なファクトリを持つこと' do
    expect(build :product).to be_valid
  end
  it '値段は1円以上であること'
  it '値段は必須であること'
  it '名前は必須であること'
end
