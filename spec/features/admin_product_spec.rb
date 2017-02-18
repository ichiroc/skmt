# coding: utf-8
# frozen_string_literal: true
require 'rails_helper'

feature '商品管理をする' do
  scenario '匿名ユーザーが直接URLを開いてもリダイレクトされる' do
    visit admin_products_path
    expect(current_path).to eq new_user_session_path
  end

  scenario '一般ユーザーが直接URLを開いてもリダイレクトされる' do
    user = create :user, password: 'password'
    sign_in user
    visit admin_products_path
    expect(current_path).to eq root_path
    expect(page).to have_content t('errors.messages.not_permitted_operation')
  end

  scenario '管理者ユーザーが商品を追加する' do
    name = 'hoge'
    description = 'foobar'
    price = 10_000

    admin = create :admin
    sign_in admin
    click_on t('menu.manage_products')
    click_on t('admin.products.index.new_product')
    fill_in t('activerecord.attributes.product.name'), with: name
    fill_in t('activerecord.attributes.product.description'), with: description
    fill_in t('activerecord.attributes.product.price'), with: price
    attach_file t('activerecord.attributes.product.image'), "#{Rails.root}/spec/images/300x300.png"
    click_on t('helpers.submit.create')

    expect(page).to have_content 'Product was successfully created.'
    product = Product.last
    expect(product.name).to eq name
    expect(product.description).to eq description
    expect(product.price).to eq price
    expect(product.image.file).not_to be_blank
  end
end
