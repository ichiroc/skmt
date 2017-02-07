module ProductsHelper
  def product_image_tag(product, options = {})
    if product.image.blank?
      image_tag '/images/dummy-300x300.png', options
    else
      image_tag product.image.url, options
    end
  end
end
