class Video < ActiveRecord::Base
  # Configuration

    mount_uploader :file, VideoUploader

  # Associations

    belongs_to :tutorial, inverse_of: :videos, counter_cache: true

  # Attributes

  # Validations

    validates :tutorial, presence: true
    validates :title, presence: true, uniqueness: true
    validates :video_url, presence: true
    validates_format_of :image_url, with: URI::regexp(%w(http https))

  # Scopes

  # Callbacks

    after_validation :download_video
    after_save :delete_temporary_file

  private

    def download_video
      if video_url_changed? || self.new_record?
        open(temporary_filename, "wb") { |file|  file.print open(video_url).read }
        self.file = File.open(temporary_filename)
      end
    end

    def temporary_filename
      @temporary_filename ||= Rails.root.join 'tmp', "#{title}.mp4"
    end

    def delete_temporary_file
      File.delete(temporary_filename) if File.exist? temporary_filename
    end
end
