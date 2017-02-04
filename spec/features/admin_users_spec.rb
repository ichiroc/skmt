# coding: utf-8
require "rails_helper"

RSpec.describe :admin_user do

  before :each do
    @admin = create :admin
  end
  feature 'ユーザー管理メニューを使う' do
    scenario '匿名ユーザーが直接URLを開いても使えない' do
      visit admin_users_path
      expect(current_path).to eq new_user_session_path
    end

    scenario '一般ユーザーがログインしてもリダイレクトされる' do
      user = create :user, password: 'password'
      sign_in user
      visit admin_users_path
      expect(current_path).to eq root_path
    end

    scenario '管理者ユーザーがログインすれば使える'  do
      sign_in @admin
      visit admin_users_path
      expect(current_path).to eq admin_users_path
    end
  end
end
