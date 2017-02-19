# frozen_string_literal: true
module ProductsHelper
  def product_image_tag(image, options = {})
    if image.file.blank?
      image_tag image_path('dummy.png'), options
    else
      image_tag image.url, options
    end
  end
end
