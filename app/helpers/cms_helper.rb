module CmsHelper
  def cms_url(url)
    if Rails.env.development?
      return url if url.starts_with?("http") || url.starts_with?("/test-images")
      "#{Rails.application.config.strapi_image_url}#{url}"
    else
      url
    end
  end

  def cms_image_url(image)
    cms_url(image.image_url)
  end

  def cms_image(image, class: nil)
    image_tag(cms_image_url(image), alt: image.alt, class:)
  end

  # border-width should be defined in the component
  def cms_color_theme_class(color, side)
    "cms-color-theme__border--#{color}-#{side}"
  end
end
