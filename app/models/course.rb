class Course < ActiveRecord::Base
  # Configuration

  # Associations

    has_many :tutorials, inverse_of: :course, dependent: :destroy
    has_many :tags, through: :tutorials

  # Attributes

  # Validations

    validates :name, presence: true, uniqueness: {case_sensitive: false}
    validates_format_of :image_url, with: URI::regexp(%w(http https))

  # Scopes

  # Callbacks
end
