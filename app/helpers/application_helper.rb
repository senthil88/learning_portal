module ApplicationHelper
  def set_image(image_url)
    image_url.present? ? image_url : asset_path('no_image.gif')
  end
end
