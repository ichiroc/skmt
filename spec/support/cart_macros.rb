module CartMacros
  def add_to_cart product
    click_link product.name
    click_link 'Add to cart'
  end
end
