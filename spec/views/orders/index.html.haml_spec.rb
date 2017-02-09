require 'rails_helper'

RSpec.describe "orders/index", type: :view do
  before(:each) do
    assign(:orders, [
      Order.create!(
        :user => nil,
        :total => 2,
        :tax_amount => 3,
        :delivery_charge => 4,
        :cache_on_delivery_fee => 5,
        :delivery_time => 6,
        :destination_name => "Destination Name",
        :destination_zip_code => "Destination Zip Code",
        :destination_address => "Destination Address"
      ),
      Order.create!(
        :user => nil,
        :total => 2,
        :tax_amount => 3,
        :delivery_charge => 4,
        :cache_on_delivery_fee => 5,
        :delivery_time => 6,
        :destination_name => "Destination Name",
        :destination_zip_code => "Destination Zip Code",
        :destination_address => "Destination Address"
      )
    ])
  end

  it "renders a list of orders" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => 6.to_s, :count => 2
    assert_select "tr>td", :text => "Destination Name".to_s, :count => 2
    assert_select "tr>td", :text => "Destination Zip Code".to_s, :count => 2
    assert_select "tr>td", :text => "Destination Address".to_s, :count => 2
  end
end
