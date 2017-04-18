# coding: utf-8
# frozen_string_literal: true
require 'rails_helper'

feature 'パンくず' do
  scenario 'トップページにはパンくずがない' do
    visit root_path
    expect(page).to_not have_link('Home')
  end

  scenario '商品ページにパンくずが表示される' do
    product = create :product
    visit root_path
    click_on product.name
    expect(page).to have_link('Home')
    expect(page).to have_content(product.name)
  end
end
