require 'rails_helper'

RSpec.describe "order_items/index", type: :view do
  before(:each) do
    assign(:order_items, [
      OrderItem.create!(
        :order => nil,
        :product => nil,
        :product_name => "Product Name",
        :price => 2,
        :quantity => 3
      ),
      OrderItem.create!(
        :order => nil,
        :product => nil,
        :product_name => "Product Name",
        :price => 2,
        :quantity => 3
      )
    ])
  end

  it "renders a list of order_items" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Product Name".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
