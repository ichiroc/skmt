module ProductsHelper
  def product_image_tag(product)
    if product.image.blank?
      image_tag '/images/dummy-300x300.png'
    else
      image_tag product.image.url
    end
  end
end
