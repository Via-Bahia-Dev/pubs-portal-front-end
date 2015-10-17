class User < ActiveRecord::Base
	validates_presence_of :email, :first_name, :last_name

	has_many :authentication_tokens
  has_secure_password
  validates :password, length: { minimum: 8 }, on: :create
  validates :password, length: { minimum: 8 }, on: :update, allow_blank: true
end
