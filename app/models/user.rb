class User < ActiveRecord::Base
  extend LdapAuth

  # Configuration

  # Associations

  # Attributes

  # Validations

    validates :name, presence: true, uniqueness: true

  # Scopes

  # Callbacks

  def self.authenticate(params)
    if ldap_authenticate(params[:username], params[:password])
      User.find_or_create_by_name(params[:username])
    end
  end
end
