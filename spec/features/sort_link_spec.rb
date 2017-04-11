# coding: utf-8
# frozen_string_literal: true

require 'rails_helper'

feature '商品を並び替えできる' do
  before :each do
    create :product, name: 'Bcd', sort_order: 1, price: 100
    create :product, name: 'Abc', sort_order: 2, price: 200
    create :product, name: 'Cde', sort_order: 3, price: 300
  end

  scenario '商品を商品名で昇順降順で並び替えする' do
    visit root_path
    expect(page.all(:css, '.products').map(&:text)).to eq %w[Bcd Abc Cde]
    # 「商品名 ▲」 をなぜか見つけられない(実体参照含む)のでidで指定する
    click_on 'sort_by_name' # 昇順
    expect(page.all(:css, '.products').map(&:text)).to eq %w[Abc Bcd Cde]
    click_link 'sort_by_name' # 降順
    expect(page.all(:css, '.products').map(&:text)).to eq %w[Cde Bcd Abc]
  end

  scenario '商品を価格で昇順降順で並び替えする' do
    visit root_path
    expect(page.all(:css, '.products').map(&:text)).to eq %w[Bcd Abc Cde]
    # 「価格 ▲」 をなぜか見つけられない(実体参照含む)のでidで指定する
    click_on 'sort_by_price' # 昇順
    expect(page.all(:css, '.products').map(&:text)).to eq %w[Bcd Abc Cde]
    click_link 'sort_by_price' # 降順
    expect(page.all(:css, '.products').map(&:text)).to eq %w[Cde Abc Bcd]
  end
end
