class Api::User::RegisterController < Devise::RegistrationsController
  protect_from_forgery prepend: true
  respond_to :json
  def create
    super do |resource|
      if resource.persisted?
        puts "persisted resource" # a user was created
      else
        puts "not persisted resource" # no user was created (be it because of duplicate field OR password not long enough)

        puts resource.errors.full_messages
        puts resource.errors.full_messages.is_a?(Array)
        puts "a".is_a?(Array)
      end
    end
  end
end
