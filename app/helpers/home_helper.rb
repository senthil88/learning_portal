module HomeHelper
  def set_image(image_url, options = {})
    class_name = options[:class].present? ? options[:class] : ''
    capture_haml do
      unless image_url.empty?
        haml_tag :img, class: class_name, src: image_url
      else
        haml_tag :img, class: class_name, src: '/assets/no_image.gif'
      end
    end
  end
end
