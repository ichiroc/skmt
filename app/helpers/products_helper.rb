module ProductsHelper
  def product_image_tag(image, options = {})
    if image.blank?
      image_tag "#{root_path}images/dummy.png", options
    else
      image_tag image.url, options
    end
  end
end
