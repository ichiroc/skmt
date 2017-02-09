# coding: utf-8
# frozen_string_literal: true
require 'rails_helper'

RSpec.describe :admin_user do
  feature 'ユーザー管理メニューを使う' do
    before :each do
      @user = create :user
    end
    scenario '匿名ユーザーが直接URLを開いても使えない' do
      visit admin_users_path
      expect(current_path).to eq new_user_session_path
    end

    scenario '一般ユーザーがログインしてもリダイレクトされる' do
      sign_in @user
      visit admin_users_path
      expect(current_path).to eq root_path
    end

    context '管理者ユーザーでログインした場合' do
      before :each do
        admin = create :admin
        sign_in admin
      end
      scenario '管理メニューを表示できる' do
        visit admin_users_path
        expect(current_path).to eq admin_users_path
      end

      scenario '編集できる' do
        click_link t('menu.admin.users_link')
        first(:link, t('helpers.links.edit')).click
        fill_in t('activerecord.attributes.user.name'), with: 'ほげ'
        click_button t('helpers.submit.update')
        expect(page).to have_content 'User was successfully updated.'
        expect(page).to have_content 'ほげ'
        @user.reload
        expect(@user.name).to eq 'ほげ'
      end
    end
  end
end
