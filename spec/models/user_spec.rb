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

  context 'Admin の場合' do
    it '最後の管理者は削除できないこと'
  end
end
