# coding: utf-8
# frozen_string_literal: true
require 'rails_helper'

RSpec.describe DeliveryDate do
  describe '最短配達日' do
    context '本日が2017/2/1(水)の場合' do
      before :each do
        Timecop.travel(2017, 2, 1)
      end
      after :each do
        Timecop.return
      end
      it '最短配達日は2017/2/6(月)になること' do
        expect(DeliveryDate.formatted_earliest_date).to eq '2017-02-06'
      end

      it '最遅配達日は2017/2/21(火)になること' do
        expect(DeliveryDate.formatted_latest_date).to eq '2017-02-21'
      end

      it '配達可能期間中の土日は除外されること' do
        expect(DeliveryDate.formatted_excluded_dates).to include('2017-02-11',
                                                                 '2017-02-12',
                                                                 '2017-02-18',
                                                                 '2017-02-19')
      end
    end
  end
end
