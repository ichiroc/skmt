# coding: utf-8
require "rails_helper"

feature '注文を確定する' do
  before :each do
    @product = create :product
    @user = create :user
    visit root_path
  end
  scenario '商品をカートに追加して、住所を入力して注文を確定する' do
    sign_in @user
    add_to_cart @product
    proceed_to_checkout
    fill_in t('activerecord.attributes.order.destination_zip_code'),
            with: Faker::Address.zip_code
    fill_in t('activerecord.attributes.order.destination_address'),
            with: Faker::Address.full_address
    fill_in t('activerecord.attributes.order.destination_name'),
            with: Faker::Name.name
    click_on t('orders.new.confirm_order')
    click_on t('orders.confirmation.submit_order')
    expect(page).to have_content(t('orders.show.thank_you'))
  end

  scenario 'ユーザーに既に住所などが登録されている場合は、登録を省略して注文を確定できる' do
    @user.destination_zip_code = Faker::Address.zip_code
    @user.destination_address = Faker::Address.full_address
    @user.destination_name = Faker::Name.name
    @user.save!
    sign_in @user
    add_to_cart @product
    proceed_to_checkout
    click_on t('orders.new.confirm_order')
    click_on t('orders.confirmation.submit_order')
    expect(page).to have_content(t('orders.show.thank_you'))
  end

  scenario '商品をカートに追加して住所を入力してユーザー情報に保存して注文を確定する' do
    zip_code = '1234567'
    address = 'hogehogehoge'
    name = 'fugafuga'

    sign_in @user
    add_to_cart @product
    proceed_to_checkout

    fill_in t('activerecord.attributes.order.destination_zip_code'),
            with: zip_code
    fill_in t('activerecord.attributes.order.destination_address'),
            with: address
    fill_in t('activerecord.attributes.order.destination_name'),
            with: name
    check t('activerecord.attributes.order.remember_destination')
    click_on t('orders.new.confirm_order')
    click_on t('orders.confirmation.submit_order')
    @user.reload
    expect(@user.destination_zip_code).to eq zip_code
    expect(@user.destination_address).to eq address
    expect(@user.destination_name).to eq name
  end
end
