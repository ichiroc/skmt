require 'rails_helper'

RSpec.describe "order_items/new", type: :view do
  before(:each) do
    assign(:order_item, OrderItem.new(
      :order => nil,
      :product => nil,
      :product_name => "MyString",
      :price => 1,
      :quantity => 1
    ))
  end

  it "renders new order_item form" do
    render

    assert_select "form[action=?][method=?]", order_items_path, "post" do

      assert_select "input#order_item_order_id[name=?]", "order_item[order_id]"

      assert_select "input#order_item_product_id[name=?]", "order_item[product_id]"

      assert_select "input#order_item_product_name[name=?]", "order_item[product_name]"

      assert_select "input#order_item_price[name=?]", "order_item[price]"

      assert_select "input#order_item_quantity[name=?]", "order_item[quantity]"
    end
  end
end
