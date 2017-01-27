require 'rails_helper'

RSpec.describe "products/index", type: :view do
  before(:each) do
    assign(:products, [
      Product.create!(
        :title => "Title",
        :description => "MyText",
        :price => 2,
        :hidden => 3,
        :sort_order => 4,
        :image => "Image"
      ),
      Product.create!(
        :title => "Title",
        :description => "MyText",
        :price => 2,
        :hidden => 3,
        :sort_order => 4,
        :image => "Image"
      )
    ])
  end

  it "renders a list of products" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => "Image".to_s, :count => 2
  end
end
