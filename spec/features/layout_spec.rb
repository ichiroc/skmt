# coding: utf-8
require "rails_helper"

RSpec.describe :layout do
  feature '管理者メニュー' do
    scenario '管理者メニューを表示する' do
      admin = create :admin
      visit root_path
      expect(page).not_to have_content '商品管理'
      expect(page).not_to have_content 'ユーザー管理'
      sign_in admin
      expect(page).to have_content '商品管理'
      expect(page).to have_content 'ユーザー管理'
    end
  end
end
