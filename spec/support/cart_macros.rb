module CartMacros
  def add_to_cart product
    click_link product.name
    click_link t('products.show.add_to_cart')
  end

  def proceed_to_checkout
    visit cart_items_path
    click_on t('cart_items.index.proceed_to_checkout')
  end
end
