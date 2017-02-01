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
      expect(product.errors[:sort_order]).to include %(must be greater than or equal to 0)
    end

    it 'デフォルトは表示順通りの順番が返ってくること'
  end

  it '名前は必須であること' do
    product.name = nil
    product.valid?
    expect(product.errors[:name]).to include %(can't be blank)
  end

  it '拡張子が画像の拡張子じゃないときはエラーになること' do
    product.image = File.new "#{Rails.root}/spec/images/dummy.txt"
    product.valid?
    expect(product.errors[:image]).to include 'extension must be a one of jpg, jpeg, png, gif'
  end

  describe '画像のファイルサイズ' do
    let(:product) { build :product, image: File.new(file_path) }
    before :each do
      product.valid?
    end
    context 'ファイルサイズが10MBを超えていると' do
      let(:file_path) { "#{Rails.root}/spec/images/over10MB.png" }
      it 'エラーになること' do
        expect(product.errors[:image]).to include 'file size must be under 10MB'
      end
    end

    skip context 'ファイルサイズが10MB以下なら' do
      skip '画像ファイルじゃないと MiniMagick でエラーになるので10MB近くの画像が手に入るまで処理をスキップする'
      let(:file_path) { "#{Rails.root}/spec/images/under10MB.png" }
      it 'アップロードできること' do
        expect(product.errors[:image]).not_to include 'file size must be under 10MB'
      end
    end
  end

  describe '画像のリサイズ' do
    let(:product) { create :product, image: File.new(image_path) }
    let(:image_file) { MiniMagick::Image.open product.image.path }
    context '300x300以下のサイズ(300x300)をアップロードした場合' do
      let(:image_path) { "#{Rails.root}/spec/images/300x300.png" }
      it 'リサイズしないこと' do
        expect([image_file.width, image_file.height]).to eq [300, 300]
      end
    end

    context '幅が300より大きいサイズ(301x300)をアップロードした場合' do
      let(:image_path) { "#{Rails.root}/spec/images/301x300.png" }
      it '幅が300にリサイズされること' do
        expect(image_file.width).to eq 300
      end
    end
    context '縦が300より大きいサイズ(300x301)をアップロードした場合' do
      let(:image_path) { "#{Rails.root}/spec/images/300x301.png" }
      it '縦が300にリサイズされること' do
        expect(image_file.height).to eq 300
      end
    end
  end
end
