# coding: utf-8
# frozen_string_literal: true
require 'rails_helper'

feature '商品管理メニューを使う' do
  scenario '匿名ユーザーが直接URLを開いても使えない' do
    visit admin_products_path
    expect(current_path).to eq new_user_session_path
  end

  scenario '一般ユーザーがログインしてもリダイレクトされる' do
    user = create :user, password: 'password'
    sign_in user
    visit admin_products_path
    expect(current_path).to eq root_path
  end

  scenario '管理者ユーザーがログインすれば使える' do
    admin = create :admin
    sign_in admin
    visit admin_products_path
    expect(current_path).to eq admin_products_path
  end
end
