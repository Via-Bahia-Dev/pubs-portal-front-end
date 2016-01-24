class RequestAttachmentsController < ApplicationController

  def create
    byebug
    res = post("/publication_requests/#{params[:publication_request_id]}/request_attachments", {:request_attachment => request_attachment_params })
    if res["errors"].nil?
      # render partial: 'show', locals: { comment: res }
    end
  end

  private
  def request_attachment_params
    params.require(:request_attachment).permit(:file, :comment)
  end

end
