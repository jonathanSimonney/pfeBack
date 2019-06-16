# frozen_string_literal: true

class User < ApplicationRecord
  acts_as_token_authenticatable

  has_many :interest_point_opinions

  has_one :profile, dependent: :destroy
  accepts_nested_attributes_for :profile

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  FORBIDDEN_FIELDS = %w[authentication_token created_at updated_at encrypted_password reset_password_token reset_password_sent_at remember_created_at].freeze

  def session_login(password)
    if valid_password?(password)
      { "json": { "auth_token": authentication_token, "id": self.id } }
    else
      { "json": { errors: { password: ['is invalid'] } }, status: :unprocessable_entity }
    end
  end

  def get_public_infos
    ret = attributes.reject { |attribute| FORBIDDEN_FIELDS.include? attribute }
    profile = self.profile
    profile[:profile_pic] = profile.profile_pic.url if profile.profile_pic
    ret[:profile] = profile
    ret
  end

  def display_name
    email
  end
end
