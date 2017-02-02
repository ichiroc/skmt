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

  context 'Admin の場合' do
    it 'is_admin= "1" でadminロールを設定できること' do
      user.is_admin = '1'
      expect(user.is_admin?).to be_truthy
    end

    it 'is_admin= "0" でadminロールを削除できること' do
      user.is_admin = '0'
      expect(user.is_admin?).to be_falsy
    end

    it '最後の管理者は削除できないこと'
  end
end
