# coding: utf-8
# frozen_string_literal: true
require 'rails_helper'

feature 'ユーザー管理メニューを使う' do
  before :each do
    @user = create :user
  end
  scenario '匿名ユーザーが直接URLを開いても使えない' do
    visit admin_users_path
    expect(current_path).to eq new_user_session_path
  end

  scenario '一般ユーザーが直接URLを開いてもリダイレクトされる' do
    sign_in @user
    visit admin_users_path
    expect(current_path).to eq root_path
    expect(page).to have_content t('errors.messages.not_permitted_operation')
  end

  scenario '管理者ユーザーでユーザーの情報を編集する' do
    admin = create :admin
    name = 'hoge'
    zip_code = '9999999'
    address = 'fuga'

    sign_in admin
    visit admin_users_path
    click_link t('menu.manage_users')
    first(:link, t('helpers.links.edit')).click
    fill_in t('activerecord.attributes.user.destination_name'), with: name
    fill_in t('activerecord.attributes.user.destination_zip_code'), with: zip_code
    fill_in t('activerecord.attributes.user.destination_address'), with: address
    click_button t('helpers.submit.update')

    expect(page).to have_content 'User was successfully updated.'
    @user.reload
    expect(@user.destination_name).to eq name
    expect(@user.destination_zip_code).to eq zip_code
    expect(@user.destination_address).to eq address
  end
end
