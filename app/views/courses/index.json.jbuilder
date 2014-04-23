json.array!(@courses) do |course|
  json.extract! course, :id, :name, :image_url, :description
  json.url course_url(course, format: :json)
end
