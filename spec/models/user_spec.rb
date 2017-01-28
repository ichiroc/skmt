# coding: utf-8
# frozen_string_literal: true
require 'rails_helper'

RSpec.describe User, type: :model do
  it '有効なファクトリを持つこと' do
    expect(build(:user)).to be_valid
  end

  it '画像を保存できること'
  it '画像以外のファイルは保存できないこと'
  it 'カートを持っていること'

  context 'Admin の場合' do
    it '最後の管理者は削除できないこと'
  end
end
