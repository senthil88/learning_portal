class User < ActiveRecord::Base
  extend LdapAuth

  # Configuration

  # Associations

  # Attributes

  # Validations

    validates :name, presence: true, uniqueness: true

  # Scopes

  # Callbacks

    after_create :update_ldap_params

  def self.authenticate(params)
    if ldap_authenticate(params[:username], params[:password])
      User.find_or_create_by_name(params[:username])
    end
  end

  private

  def update_ldap_params
    self.update_attributes User.get_ldap_entities(name)
  end
end
