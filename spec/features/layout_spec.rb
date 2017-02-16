# coding: utf-8
require "rails_helper"

RSpec.describe :layout do
  feature '管理者メニュー' do
    scenario '管理者メニューを表示する' do
      admin = create :admin
      visit root_path
      expect(page).not_to have_content t('menu.manage_products')
      expect(page).not_to have_content t('menu.manage_users')
      sign_in admin
      expect(page).to have_content t('menu.manage_products')
      expect(page).to have_content t('menu.manage_users')
    end
  end
end
