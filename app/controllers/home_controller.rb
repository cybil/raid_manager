class HomeController < ApplicationController
  def index
    @characters = Character.all
    render json: @characters
  end
end
