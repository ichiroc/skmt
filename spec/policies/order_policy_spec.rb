# coding: utf-8
# frozen_string_literal: true
require 'rails_helper'

RSpec.describe OrderPolicy do

  let(:order) { build :order }
  let(:user) { build :user }
  let(:admin) { build :admin }

  subject { described_class }

  permissions '.scope' do
    before :each do
      10.times { create :order }
    end
    context 'Admin の場合' do
      let(:user) { build :admin }
      it '全て表示される' do
        orders = OrderPolicy::Scope.new(user, Order).resolve
        expect(orders.count).to eq 10
      end
    end
    context '一般ユーザー の場合' do
      let(:user) { Order.first.user }
      it '自分の分のみ表示される' do
        users_orders = Order.where user: user
        orders = OrderPolicy::Scope.new(user, Order).resolve
        expect(orders.count).to eq users_orders.count
      end
    end
  end

  permissions :show? do
    context 'Admin の場合' do
      it '全て表示できる' do
        expect(OrderPolicy).to permit(admin, build(:order))
      end
    end

    context '一般ユーザーの場合' do
      it '自分の注文のみ表示できる' do
        order.user = user
        expect(OrderPolicy).to permit(user, order)
        another_user = create :user
        expect(OrderPolicy).not_to permit(another_user, order)
      end
    end
  end

  permissions :create? do
    it '自分の注文のみ作成できる' do
      order.user = user
      expect(OrderPolicy).to permit(user, order)
      another_user = create :user
      expect(OrderPolicy).not_to permit(another_user, order)
    end
  end

  permissions :update? do
    it 'Adminだけが注文を更新できる' do
      order.user = user
      expect(OrderPolicy).to permit(admin, order)
      expect(OrderPolicy).not_to permit(user, order)
    end
  end
end
