class RequestAttachmentsController < ApplicationController

  def create
    res = post("/publication_requests/#{params[:publication_request_id]}/request_attachments", {:request_attachment => request_attachment_params })
    if res["errors"].nil?
      render partial: 'show', locals: { attachment: res }
    end
  end

  def destroy
    res = delete("/request_attachments/#{params[:id]}")

    if res['errors'].nil?
      head :no_content 
    else
      flash[:errors] = res['errors']
      render 'show'
    end
  end

  private
  def request_attachment_params
    params.require(:request_attachment).permit(:file, :comment)
  end

end
