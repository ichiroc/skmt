# coding: utf-8
require "rails_helper"

RSpec.describe Cart do
  feature 'カートに商品を追加する' do
    before :each do
      @product = create :product
    end
    scenario '未ログインの状態でカートに追加する' do
      expect(CartItem.count).to eq 0
      visit root_path
      add_to_cart @product
      expect(CartItem.count).to eq 1
    end

    scenario '未ログインの状態でカートに追加した後にログインするとカートを引き継ぐ' do
      user = create :user
      visit root_path
      add_to_cart @product
      user.reload
      expect(user.cart.items.count).to eq 0
      sign_in user
      click_link "#{t('menu.cart_link')}( 1 )"
      expect(page).to have_content @product.name
      user.reload
      expect(user.cart.items.count).to eq 1
    end
  end
end
