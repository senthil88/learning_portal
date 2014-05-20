module ApplicationHelper
  def set_image(image_url)
    image_url.present? ? image_url : '/assets/no_image.gif'
  end
end
