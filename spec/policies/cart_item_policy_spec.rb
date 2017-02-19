# coding: utf-8
require 'rails_helper'

RSpec.describe CartItemPolicy do

  let(:item) { build :cart_item }
  let(:user) { build :user }
  subject { described_class }

  before :each do
    item.cart.user = cart_owner
  end

  permissions :create? do
    context '自分のカートの場合は' do
      let(:cart_owner) { user }
      it 'アイテムを追加できる' do
        expect(subject).to permit(user, item)
      end
    end
    context '別ユーザーのカートの場合は' do
      let(:cart_owner) { build :user }
      it 'アイテムを追加できない' do
        expect(subject).not_to permit(user, item)
      end
    end
  end

  permissions :update? do
    context '自分のカートの場合は' do
      let(:cart_owner) { user }
      it 'アイテムを更新できる' do
        expect(subject).to permit(user, item)
      end
    end
    context '別ユーザーのカートの場合は' do
      let(:cart_owner) { build :user }
      it 'アイテムを更新できない' do
        expect(subject).not_to permit(user, item)
      end
    end
  end

  permissions :destroy? do
    context '自分のカートの場合は' do
      let(:cart_owner) { user }
      it 'アイテムを削除できる' do
        expect(subject).to permit(user, item)
      end
    end
    context '別ユーザーのカートの場合は' do
      let(:cart_owner) { build :user }
      it 'アイテムを削除できない' do
        expect(subject).not_to permit(user, item)
      end
    end
  end
end
