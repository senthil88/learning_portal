class Tag < ActiveRecord::Base
  # 1. Configuration

  # 2. Associations

    has_and_belongs_to_many :tutorials

  # 3. Attributes

  # 4. Validations

    validates :name, presence: true, uniqueness: {case_sensitive: false}

  # 5. Scopes

  # 6. Callbacks
end
