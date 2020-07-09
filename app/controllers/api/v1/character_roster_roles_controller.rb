module Api
  module V1
    class CharacterRosterRolesController < ApplicationController
      before_action :set_character_roster_role, only: [:show, :update, :destroy]

      # GET /character_roster_roles
      def index
        @character_roster_roles = CharacterRosterRole.all

        render json: @character_roster_roles
      end

      # GET /character_roster_roles/1
      def show
        render json: @character_roster_role
      end

      # POST /character_roster_roles
      def create
        @character_roster_role = CharacterRosterRole.new(character_roster_role_params)

        if @character_roster_role.save
          render json: @character_roster_role, status: :created
        else
          render json: @character_roster_role.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /character_roster_roles/1
      def update
        if @character_roster_role.update(character_roster_role_params)
          render json: @character_roster_role
        else
          render json: @character_roster_role.errors, status: :unprocessable_entity
        end
      end

      # DELETE /character_roster_roles/1
      def destroy
        @character_roster_role.destroy
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_character_roster_role
        @character_roster_role = CharacterRosterRole.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def character_roster_role_params
        params.require(:character_roster_role).permit(:slot_id, :character_id, :roster_id)
      end
    end
  end
end
