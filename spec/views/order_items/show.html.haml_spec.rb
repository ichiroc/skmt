require 'rails_helper'

RSpec.describe "order_items/show", type: :view do
  before(:each) do
    @order_item = assign(:order_item, OrderItem.create!(
      :order => nil,
      :product => nil,
      :product_name => "Product Name",
      :price => 2,
      :quantity => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/Product Name/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
  end
end
