class StatusesController < ApplicationController
  def index
    @statuses = get("/statuses")
  end

  
end
