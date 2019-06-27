class Message < ApplicationRecord
  belongs_to :author, class_name => 'User', foreign_key: 'author'
  belongs_to :receptor, class_name => 'User', foreign_key: 'receptor'
end
