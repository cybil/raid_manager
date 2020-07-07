module Api
  module V1
    class RoostersController < ApplicationController
      before_action :authorize_access_request!
      before_action :set_rooster, only: [:show, :update, :destroy]

      # GET /roosters
      def index
        @roosters = Rooster.all

        render json: @roosters
      end

      # GET /roosters/1
      def show
        render json: @rooster
      end

      # POST /roosters
      def create
        @rooster = Rooster.new(rooster_params)

        if @rooster.save
          render json: @rooster, status: :created
        else
          render json: @rooster.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /roosters/1
      def update
        if @rooster.update(rooster_params)
          render json: @rooster
        else
          render json: @rooster.errors, status: :unprocessable_entity
        end
      end

      # DELETE /roosters/1
      def destroy
        @rooster.destroy
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_rooster
        @rooster = Rooster.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def rooster_params
        params.require(:rooster).permit(:name)
      end
    end
  end
end
