json.array!(@tutorials) do |tutorial|
  json.extract! tutorial, :id, :title, :image_url, :description, :course_id
  json.url tutorial_url(tutorial, format: :json)
end
