class User < ApplicationRecord
  acts_as_token_authenticatable

  has_one :profile, dependent: :destroy
  accepts_nested_attributes_for :profile

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  FORBIDDEN_FIELDS = %w(authentication_token created_at updated_at encrypted_password reset_password_token reset_password_sent_at remember_created_at)

  def session_login(password)
    if self.valid_password?(password)
      {"json": {"auth_token": self.authentication_token}}
    else
      {"json": {errors: {:password => ['is invalid']}}, status: :unprocessable_entity}
    end
  end

  def get_public_infos
    ret = self.attributes.select {|attribute| not FORBIDDEN_FIELDS.include? attribute}
    profile = self.profile
    if profile.profile_pic
      profile[:profile_pic] = profile.profile_pic.url
    end
    ret[:profile] = profile
    ret
  end

  def display_name
    self.email
  end
end
