class ChangePasswordForm
  # include ActiveModel::Model
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  # validations for password form
  validates_presence_of :current_password, :password, :password_confirmation
  validates_confirmation_of :password
  validates_length_of :password, minimum: 8
  validate :verify_current_password

  attr_accessor :current_password, :password, :password_confirmation

  def initialize(user)
    @user = user
  end

  def submit(params)
    self.current_password = params[:current_password]
    self.password = params[:password]
    self.password_confirmation = params[:password_confirmation]

    if valid?
      @user.password = password
      @user.password_confirmation = password_confirmation
      @user.save!
      true
    else
      false
    end
  end

  def verify_current_password
    self.errors.add :current_password, "is not correct" unless @user.authenticate(current_password)
  end

end
