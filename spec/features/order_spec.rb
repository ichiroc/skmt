# coding: utf-8
require "rails_helper"

feature '注文を確定する' do
  before :each do
    @product = create :product
    @user = create :user
    visit root_path
  end
  scenario '商品をカートに追加して注文を確定する' do
    sign_in @user
    add_to_cart @product
    proceed_to_order
    fill_in t('activerecord.attributes.order.destination_zip_code'),
            with: Faker::Address.zip_code
    fill_in t('activerecord.attributes.order.destination_address'),
            with: Faker::Address.full_address
    fill_in t('activerecord.attributes.order.destination_name'),
            with: Faker::Name.name
    click_on t('orders.new.submit_order')
    expect(page).to have_content(t('orders.show.thank_you'))
  end

  scenario 'ユーザーに既に住所などが登録されている場合は、登録を省略して注文を確定できる' do
    @user.zip_code = Faker::Address.zip_code
    @user.address = Faker::Address.full_address
    @user.name = Faker::Name.name
    @user.save!
    sign_in @user
    add_to_cart @product
    proceed_to_order
    click_on t('orders.new.submit_order')
    expect(page).to have_content(t('orders.show.thank_you'))
  end
end
