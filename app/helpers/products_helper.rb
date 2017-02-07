module ProductsHelper
  def product_image_tag(image, options = {})
    if image.blank?
      image_tag '/images/dummy-300x300.png', options
    else
      image_tag image.url, options
    end
  end
end
