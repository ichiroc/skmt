require 'rails_helper'

RSpec.describe "products/edit", type: :view do
  before(:each) do
    @product = assign(:product, Product.create!(
      :title => "MyString",
      :description => "MyText",
      :price => 1,
      :hidden => 1,
      :sort_order => 1,
      :image => "MyString"
    ))
  end

  it "renders the edit product form" do
    render

    assert_select "form[action=?][method=?]", product_path(@product), "post" do

      assert_select "input#product_title[name=?]", "product[title]"

      assert_select "textarea#product_description[name=?]", "product[description]"

      assert_select "input#product_price[name=?]", "product[price]"

      assert_select "input#product_hidden[name=?]", "product[hidden]"

      assert_select "input#product_sort_order[name=?]", "product[sort_order]"

      assert_select "input#product_image[name=?]", "product[image]"
    end
  end
end
