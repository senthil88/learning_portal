class Course < ActiveRecord::Base
  # Configuration

  # Associations

    has_many :tutorials, dependent: :destroy
    has_many :tags, through: :tutorials

  # Attributes

  # Validations

    validates :name, presence: true, uniqueness: {case_sensitive: false}
    validates_format_of :image_url, with: URI::regexp(%w(http https))

  # Scopes

  # Callbacks


  def self.create_from_yaml!
    courses_yml = Rails.root.join('db', 'seeds', 'courses.yml')

    if File.exists? courses_yml
      YAML.load(File.read(courses_yml)).each do |course_attribute|
        course_attribute.symbolize_keys!

        # Create courses
        course = Course.first_or_initialize(name: course_attribute[:name]).tap do |course|
          course.image_url = course_attribute[:image_url]
          course.description = course_attribute[:description]
        end.save!

        # Create Tutorials for course
        course_attribute[:tutorials].each do |tutorial_attribute|
          tutorial_attribute.symbolize_keys!
          tutorial = course.tutorials.first_or_initialize(title: tutorial_attribute[:title]).tap do |tutorial|
            tutorial.image_url = tutorial_attribute[:image_url]
            tutorial.description = tutorial_attribute[:description]
          end.save!

          # Create Tag for tutorial
          tutorial_attribute[:tags].each {|tag_attribute| tutorial.tags.find_or_create_by! name: tag_attribute["name"]}

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
    end
  end
end
