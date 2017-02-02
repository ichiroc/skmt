# coding: utf-8
require "rails_helper"

RSpec.describe :layout do
  before :each do
    create :admin
  end
  feature '管理者メニュー' do
    scenario '管理者メニューを表示する' do
      visit root_path
      expect(page).not_to have_content '管理者メニュー'

      click_link 'ログイン'
      fill_in 'Email', with: 'admin@admin'
      fill_in 'Password', with: 'password'
      click_button 'Log in'
      expect(page).to have_content '管理者メニュー'
    end
  end
end
