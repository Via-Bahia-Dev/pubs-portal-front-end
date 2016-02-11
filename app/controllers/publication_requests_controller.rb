class PublicationRequestsController < ApplicationController

  def show
    @publication_request = get("/publication_requests/#{params[:id]}")
    @publication_request_obj = PublicationRequest.find(params[:id])

    @statuses = get("/statuses")

    @templates = get("/templates")

    get_user_editable_options

    # dummy models for form_for
    @comment = Comment.new(:publication_request => @publication_request_obj)
    @attachment = RequestAttachment.new(:publication_request => @publication_request_obj)
  end

  def new
    @publication_request = PublicationRequest.new
    if params[:template_id]
      @publication_request.template_id = params[:template_id]
    end

    @template = get("/templates/#{params[:template_id]}")

    get_user_options

  end

  def create
    @publication_request = PublicationRequest.new(publication_request_params)

    @template = get("/templates/#{params[:publication_request][:template_id]}")

    get_user_options

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

  def update
    # go through the params looking for dates and format them to be date objects
    publication_request_params.each do |param, value|
      if param == 'rough_date' || param == 'due_date' || param == 'event_date'
        params[:publication_request][param] = date_obj_from(value)
      end
    end

    res = put("/publication_requests/#{params[:id]}", {:publication_request => publication_request_params})
    if res["errors"].nil?
      new_request = get("/publication_requests/#{params[:id]}")

      # If we updated the status, need to return the new workflow partial
      if publication_request_params.include? :status_id
        @statuses = get("/statuses")
        render partial: 'workflow', locals: { publication_request: new_request }
      # If we updated the template, need to return the new template partial
      elsif publication_request_params.include? :template_id
        render partial: 'chosen_template', locals: { publication_request: new_request }
      else
        head :no_content
      end
    else
      # @publication_request.save
      render :json => res.parsed_response["errors"]
    end
  end

  private

  def publication_request_params
    params.require(:publication_request).permit(:event, :description, :dimensions, :rough_date, :due_date, :event_date, :admin_id, :reviewer_id, :designer_id, :status_id, :template_id)
  end
end
