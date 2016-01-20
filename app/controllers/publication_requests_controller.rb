class PublicationRequestsController < ApplicationController

  def show
    @publication_request = get("/publication_requests/#{params[:id]}")
    @publication_request_obj = PublicationRequest.find(params[:id])
    @comment = Comment.new(:publication_request => @publication_request_obj)
  end

  def new
  	puts "*********************"
  	puts "starting new pub request"
  	puts "*************************"
    @publication_request = PublicationRequest.new
    if params[:template_id]
      @publication_request.template_id = params[:template_id]
    end

    puts "**********************"
    puts "Set template"
    puts "***********************"

    @template = get("/templates/#{params[:template_id]}")
    puts "***************************"
    puts "Got template"
    puts "***************************"
    admins = get("/users/admins")
    @admins_options = admins.map { |user| [ "#{user['first_name']} #{user['last_name']}", user['id']] }

    designers = get("/users/designers")
    @designers_options = designers.map { |user| [ "#{user['first_name']} #{user['last_name']}", user['id']] }

    reviewers = get("/users/reviewers")
    @reviewers_options = reviewers.map { |user| [ "#{user['first_name']} #{user['last_name']}", user['id']] }

  end

  def create
    # params[:publication_request][:user_id] = current_user.id
    @publication_request = PublicationRequest.new(publication_request_params)

    @template = get("/templates/#{params[:publication_request][:template_id]}")

    admins = get("/users/admins")
    @admins_options = admins.map { |user| [ "#{user['first_name']} #{user['last_name']}", user['id']] }

    designers = get("/users/designers")
    @designers_options = designers.map { |user| [ "#{user['first_name']} #{user['last_name']}", user['id']] }

    reviewers = get("/users/reviewers")
    @reviewers_options = reviewers.map { |user| [ "#{user['first_name']} #{user['last_name']}", user['id']] }
    # We need the ActiveRecord of the model in order to add it to the Publication Request association
    # @publication_request.templates << Template.find(params[:publication_request][:template_id])
    # we merge in a list of the Template model in order to build the association on create
    res = post("/publication_requests", {:publication_request => publication_request_params })
    if res["errors"].nil?
      flash[:success] = "Request for #{res["event"]} submitted!"
      redirect_to root_path
    else
      @publication_request.save
      @errors = res.parsed_response["errors"]
      render :new
    end
  end


  private

  def publication_request_params
    params.require(:publication_request).permit(:event, :description, :dimensions, :rough_date, :due_date, :event_date, :admin_id, :reviewer_id, :designer_id, :status, :template_id)
  end
end
