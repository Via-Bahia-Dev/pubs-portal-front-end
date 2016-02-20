class User < ActiveRecord::Base
	validates_presence_of :email, :first_name, :last_name
  # validates :email, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, message: "is an invalid email address"}
  # validates_uniqueness_of :email

	has_many :authentication_tokens
  has_many :publication_requests
  has_many :request_attachments
  has_many :requests_as_admin, :class_name => 'PublicationRequest', :foreign_key => 'admin_id'
  has_many :requests_as_designer, :class_name => 'PublicationRequest', :foreign_key => 'designer_id'
  has_many :requests_as_reviewer, :class_name => 'PublicationRequest', :foreign_key => 'reviewer_id'
  has_many :comments
  has_many :templates
  has_secure_password
  validates :password, length: { minimum: 8 }, on: :create
  validates :password, length: { minimum: 8 }, on: :update, allow_blank: true

  before_save :give_user_role

  def self.ROLES
  	%i[admin designer reviewer user banned]
  end

  def roles=(roles)
  	roles = [*roles].map { |r| r.to_sym }
  	self.roles_mask = (roles & User.ROLES).map { |r| 2**User.ROLES.index(r) }.inject(0, :+)
  end

  def roles
  	User.ROLES.reject do |r|
  		((roles_mask.to_i || 0) & 2**User.ROLES.index(r)).zero?
		end
	end

	def has_role?(role)
		roles.include?(role)
	end

  def add_roles(roles)
    self.roles = self.roles.concat(roles)
    self.save!
  end

	def send_password_reset
		generate_token(:password_reset_token)
		self.password_reset_sent_at = Time.zone.now
		save!
		UserMailer.password_reset(self).deliver_now
	end

	def generate_token(column)
		loop do
			self[column] = SecureRandom.urlsafe_base64
			unless User.exists?(column => self[column])
				break
			end
		end
	end

  private
    def give_user_role
      self.roles=(self.roles << :user)
    end

end
