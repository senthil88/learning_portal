class Tutorial < ActiveRecord::Base
  # Configuration

  # Associations

    has_many :videos, -> { order(created_at: :asc) }, inverse_of: :tutorial, dependent: :destroy
    has_and_belongs_to_many :tags
    belongs_to :course, inverse_of: :tutorials

  # Attributes

  # Validations

    validates :title, presence: true, uniqueness: true
    validates :course, presence: true
    validates_format_of :image_url, meassge: 'Invalid URL', with: URI::regexp(%w(http https))

  # Scopes
    default_scope { order(created_at: :desc) }

  # Callbacks

  def create_tag(tag_name)
    self.tags << Tag.find_or_create_by(name: tag_name)
  end
end
