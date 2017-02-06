# coding: utf-8
require "rails_helper"

RSpec.describe Cart do
  feature 'カートに商品を追加する' do
    before :each do
      @product = create :product
      @user = create :user
    end
    scenario '未ログインの状態でカートに追加する' do
      expect(CartItem.count).to eq 0
      visit root_path
      click_link @product.name
      click_link 'Add to cart'
      expect(CartItem.count).to eq 1
    end

    scenario '未ログインの状態でカートに追加した後にログインするとカートを引き継ぐ' do
      expect(CartItem.count).to eq 0
      visit root_path
      click_link @product.name
      click_link 'Add to cart'
      expect(CartItem.count).to eq 1
      click_link t('menu.login_link')
      sign_in @user
      click_link "#{t('menu.cart_link')}( 1 )"
      expect(page).to have_content @product.name
    end
  end
end
