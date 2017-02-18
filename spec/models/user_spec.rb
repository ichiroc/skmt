# coding: utf-8
# frozen_string_literal: true
require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user){ build :user }
  it { is_expected.to be_valid }

  it 'カートが自動的に生成されること' do
    user.cart = nil
    user.valid?
    expect(user.cart).to be_a Cart
  end

  it '通常作成されるユーザーは admin でないこと' do
    expect(user.is_admin?).to be false
  end

  describe '郵便番号' do
    it '保存するとハイフンが除去されること' do
      user.destination_zip_code = '123-4567'
      user.save!
      expect(user.destination_zip_code).to eq '1234567'
    end

    it '省略して保存できること' do
      user.destination_zip_code = nil
      user.valid?
      expect(user.errors[:destination_zip_code]).to be_blank
    end

    it '適切でない時は保存できないこと' do
      user.destination_zip_code = '12345678'
      user.valid?
      expect(user.errors[:destination_zip_code]).to include t('errors.messages.destination_zip_code')
      user.destination_zip_code = '123456'
      user.valid?
      expect(user.errors[:destination_zip_code]).to include t('errors.messages.destination_zip_code')
    end

    it '適切な形式の場合は保存できること' do
      user.destination_zip_code = '1234567'
      user.valid?
      expect(user.errors[:destination_zip_code]).to be_blank
    end
  end

  it 'is_admin= "1" でadminロールを設定できること' do
    user.is_admin = '1'
    expect(user.is_admin?).to be_truthy
  end

  it 'is_admin= "0" でadminロールを削除できること' do
    user.is_admin = '0'
    expect(user.is_admin?).to be_falsy
  end

  describe '管理者の削除' do
    before :each do
      @admin = create :admin
    end
    context '管理者が一人だけの場合' do
      it '削除できないこと' do
        @admin.destroy
        expect( @admin.destroyed? ).to be_falsy
        expect( @admin.errors[:base]).to include t('errors.messages.cant_delete_last_admin')
      end
    end
    context '最後の管理者じゃない場合' do
      it '削除できること' do
        another_admin = create :admin, email: 'admin2@admin'
        expect(another_admin.is_admin?).to be_truthy
        expect(another_admin.destroy).to be_truthy
      end
    end
  end
end
