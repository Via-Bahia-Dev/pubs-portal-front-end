class CommentsController < ApplicationController

  def create
    res = post("/publication_requests/#{params[:publication_request_id]}/comments", {:comment => comment_params })

    if res["errors"].nil?
      render partial: 'show', locals: { comment: res }
    end
  end

  def update
    res = put("/comments/#{params[:id]}", {:comment => comment_params})

    if res['errors'].nil?
      head :no_content
    end
  end

  def destroy

    res = delete("/comments/#{params[:id]}")

    if res['errors'].nil?
      head :no_content
    else
      flash[:errors] = res['errors']
      render 'show'
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end

end
