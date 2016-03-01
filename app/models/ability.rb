class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user.roles == []
      guest_abilities
    end

    if user.has_role? :user
      user_user_abilities(user)
      user_attachment_abilities(user)
      user_comment_abilities(user)
      user_template_abilities
      user_request_abilities(user)
      user_status_abilities
    end

    if user.has_role? :designer
      designer_request_abilities(user)
    end

    if user.has_role? :reviewer
      reviewer_request_abilities(user)
    end

    can :manage, :all if user.has_role? :admin

  end

  def guest_abilities
    can :create, :session
    can :create, :password_reset
    can :update, :password_reset
  end

  def user_user_abilities(user)
    can :destroy, :session # users can sign out
    can :show, User, :id => user.id # users can view their own profile
    can :update, User, :id => user.id # users can update their own profile
    can :update_password, User, :id => user.id # users can change their own password
    can :admins, User
    can :reviewers, User
    can :designers, User
  end

  def user_attachment_abilities(user)
    standard_crud(user, RequestAttachment)
  end

  def user_comment_abilities(user)
    standard_crud(user, Comment)
  end

  def user_template_abilities
    can :read, Template
  end

  def user_status_abilities
    can :read, Status
  end

  def user_request_abilities(user)
    can :read, PublicationRequest, :user_id => user.id
    can :create, PublicationRequest
  end

  def designer_request_abilities(user)
    can :read, PublicationRequest, :designer_id => user.id
    can :design, PublicationRequest, :designer_id => user.id
  end

  def reviewer_request_abilities(user)
    can :read, PublicationRequest, :reviewer_id => user.id
    can :review, PublicationRequest, :reviewer_id => user.id
  end

  def standard_crud(user, model)
    can :create, model
    can :read, model
    can :update, model, :user_id => user.id
    can :destroy, model, :user_id => user.id
  end

end
