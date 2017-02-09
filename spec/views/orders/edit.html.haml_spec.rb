require 'rails_helper'

RSpec.describe "orders/edit", type: :view do
  before(:each) do
    @order = assign(:order, Order.create!(
      :user => nil,
      :total => 1,
      :tax_amount => 1,
      :delivery_charge => 1,
      :cache_on_delivery_fee => 1,
      :delivery_time => 1,
      :destination_name => "MyString",
      :destination_zip_code => "MyString",
      :destination_address => "MyString"
    ))
  end

  it "renders the edit order form" do
    render

    assert_select "form[action=?][method=?]", order_path(@order), "post" do

      assert_select "input#order_user_id[name=?]", "order[user_id]"

      assert_select "input#order_total[name=?]", "order[total]"

      assert_select "input#order_tax_amount[name=?]", "order[tax_amount]"

      assert_select "input#order_delivery_charge[name=?]", "order[delivery_charge]"

      assert_select "input#order_cache_on_delivery_fee[name=?]", "order[cache_on_delivery_fee]"

      assert_select "input#order_delivery_time[name=?]", "order[delivery_time]"

      assert_select "input#order_destination_name[name=?]", "order[destination_name]"

      assert_select "input#order_destination_zip_code[name=?]", "order[destination_zip_code]"

      assert_select "input#order_destination_address[name=?]", "order[destination_address]"
    end
  end
end
