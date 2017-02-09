require 'rails_helper'

RSpec.describe "orders/show", type: :view do
  before(:each) do
    @order = assign(:order, Order.create!(
      :user => nil,
      :total => 2,
      :tax_amount => 3,
      :delivery_fee => 4,
      :cache_on_delivery_fee => 5,
      :delivery_time_zone => 6,
      :destination_name => "Destination Name",
      :destination_zip_code => "Destination Zip Code",
      :destination_address => "Destination Address"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/5/)
    expect(rendered).to match(/6/)
    expect(rendered).to match(/Destination Name/)
    expect(rendered).to match(/Destination Zip Code/)
    expect(rendered).to match(/Destination Address/)
  end
end
