# coding: utf-8
require "rails_helper"

RSpec.describe :layout do
  feature '管理者メニュー' do
    context '一般ユーザーの場合' do
      let(:user) { create :user }
      scenario '一般ユーザーで入ると非表示する' do
        visit root_path
        expect(page).not_to have_content t('menu.manage_products')
        expect(page).not_to have_content t('menu.manage_users')
        sign_in user
        expect(page).not_to have_content t('menu.manage_products')
        expect(page).not_to have_content t('menu.manage_users')
      end
    end
    context '管理者ユーザーの場合' do
      let(:user){ create :admin }
      scenario '管理者で入ると管理者メニューを表示する' do
        visit root_path
        expect(page).not_to have_content t('menu.manage_products')
        expect(page).not_to have_content t('menu.manage_users')
        sign_in user
        expect(page).to have_content t('menu.manage_products')
        expect(page).to have_content t('menu.manage_users')
      end
    end
  end
end
