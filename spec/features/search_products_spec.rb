# coding: utf-8
require "rails_helper"

feature '商品検索' do
  before :each do
    create :product, { name: '自転車A' }
    create :product, { name: '一輪車B' }
  end

  scenario '商品名で検索する' do
    visit root_path
    expect(page).to have_link('自転車A')
    expect(page).to have_link('一輪車B')
    fill_in :q_name_or_description_cont, with: '自転車'
    click_on '検索'
    expect(page).to have_link('自転車A')
    expect(page).not_to have_link('一輪車B')
  end
end
