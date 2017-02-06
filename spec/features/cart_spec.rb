# coding: utf-8
require "rails_helper"

RSpec.describe Cart do
  feature 'カートに商品を追加する' do
    scenario '未ログインの状態でカートに追加する' do
      product = create :product
      visit root_path
      save_and_open_page
      click_link product.name
      click_link 'Add to cart'
      expect(CartItem.count).to eq 1
    end
  end
end
