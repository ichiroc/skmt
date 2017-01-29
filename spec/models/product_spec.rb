# coding: utf-8
# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Product, type: :model do
  subject(:product) { build :product }

  it { is_expected.to be_valid }

  describe '金額を設定する' do
    it '0円の場合は無効であること' do
      product.price = 0
      product.valid?
      expect(product.errors[:price]).to include %(must be greater than 0)
    end

    it '値段は必須であること' do
      product.price = nil
      product.valid?
      expect(product.errors[:price]).to include %(can't be blank)
    end
  end

  describe '表示順を設定する' do
    it '必須であること' do
      product.sort_order = nil
      product.valid?
      expect(product.errors[:sort_order]).to include %(can't be blank)
    end

    it 'マイナスの場合は無効であること' do
      product.sort_order = -1
      product.valid?
      expect(product.errors[:sort_order]).to include %(must be greater than 0)
    end

    it 'デフォルトは表示順通りの順番が返ってくること'
  end

  it '名前は必須であること' do
    product.title = nil
    product.valid?
    expect(product.errors[:title]).to include %(can't be blank)
  end

  it '拡張子が画像の拡張子じゃないときはエラーになること' do
    product.image = File.new "#{Rails.root}/spec/images/dummy.txt"
    product.valid?
    expect(product.errors[:image]).to include 'extension must be a one of jpg, jpeg, png, gif'
  end
end
