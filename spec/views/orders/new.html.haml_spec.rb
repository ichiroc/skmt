require 'rails_helper'

RSpec.describe "orders/new", type: :view do
  before(:each) do
    assign(:order, Order.new(
      :user => nil,
      :total => 1,
      :tax_amount => 1,
      :delivery_fee => 1,
      :cache_on_delivery_fee => 1,
      :delivery_time_zone => 1,
      :destination_name => "MyString",
      :destination_zip_code => "MyString",
      :destination_address => "MyString"
    ))
  end

  it "renders new order form" do
    render

    assert_select "form[action=?][method=?]", orders_path, "post" do

      assert_select "input#order_user_id[name=?]", "order[user_id]"

      assert_select "input#order_total[name=?]", "order[total]"

      assert_select "input#order_tax_amount[name=?]", "order[tax_amount]"

      assert_select "input#order_delivery_fee[name=?]", "order[delivery_fee]"

      assert_select "input#order_cache_on_delivery_fee[name=?]", "order[cache_on_delivery_fee]"

      assert_select "input#order_delivery_time_zone[name=?]", "order[delivery_time_zone]"

      assert_select "input#order_destination_name[name=?]", "order[destination_name]"

      assert_select "input#order_destination_zip_code[name=?]", "order[destination_zip_code]"

      assert_select "input#order_destination_address[name=?]", "order[destination_address]"
    end
  end
end
