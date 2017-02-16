module CartMacros
  def add_to_cart product
    click_link product.name
    click_link 'Add to cart'
  end

  def proceed_to_order
    click_on t('menu.cart')
    click_on 'Proceed To Checkout'
  end
end
