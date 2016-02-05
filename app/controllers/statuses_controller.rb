class StatusesController < ApplicationController
  def index
    @statuses = get("/statuses")
  end

  def update
    if status_params.include?(:color)
      hex_color = params[:status][:color]
      params[:status][:color] = hex_color_to_int(status_params[:color])
    end

    put("/statuses/#{params[:id]}", { :status => status_params })

    # convert back to hex
    params[:status][:color] = hex_color
    render json: params
  end

  private

  def status_params
    params.require(:status).permit(:name, :color, :order)
  end
end
