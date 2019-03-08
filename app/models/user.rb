class User < ApplicationRecord
  acts_as_token_authenticatable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  def session_login(password)
    if self.valid_password?(password)
      {"json": {"auth_token": self.authentication_token}}
    else
      {"json": {errors: {:password => ['is invalid']}}, status: :unprocessable_entity}
    end
  end
end
