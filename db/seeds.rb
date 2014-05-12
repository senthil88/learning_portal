def seed(table_name)
  yaml_file = Rails.root.join('db', 'seeds', "#{table_name}.yml")

  if File.exists? yaml_file
    YAML.load(File.read(yaml_file)).each do |attributes|
      attributes.symbolize_keys!

      yield attributes
    end
  end
end

seed :courses do |course_attribute|
  # Create courses
  course = Course.find_or_create_by! name: course_attribute[:name] do |course|
    course.image_url = course_attribute[:image_url]
    course.description = course_attribute[:description]
  end

  # Create Tutorials for course
  course_attribute[:tutorials].each do |tutorial_attribute|
    tutorial_attribute.symbolize_keys!
    tutorial = course.tutorials.find_or_create_by! title: tutorial_attribute[:title] do |tutorial|
      tutorial.image_url = tutorial_attribute[:image_url]
      tutorial.description = tutorial_attribute[:description]
    end

    # Create Tag for tutorial
    tutorial_attribute[:tags].each {|tag_attribute| tutorial.tags << Tag.find_or_create_by!(name: tag_attribute["name"])}

    # Create Videos for tutorial
    tutorial_attribute[:videos].each do |video_attribute|
      video_attribute.symbolize_keys!
      tutorial.videos.first_or_initialize(title: video_attribute[:title]).tap do |video|
        video.video_url = video_attribute[:video_url]
        video.image_url = video_attribute[:image_url]
        video.description = video_attribute[:description]
      end.save!
    end
  end
end
