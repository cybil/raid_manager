module Api
  module V1
    class RostersController < ApplicationController
      before_action :authorize_access_request!
      before_action :set_roster, only: [:show, :update, :destroy, :update_slot]

      # GET /rosters
      def index
        @rosters = Roster.all

        render json: @rosters
      end

      # GET /rosters/1
      def show
        render json: @roster
      end

      # POST /rosters
      def create
        @roster = Roster.new(roster_params)
        compo = BasicCompo.find params[:compo_id]
        @roster.template = compo.template

        if @roster.save
          render json: @roster, status: :created
        else
          render json: @roster.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /rosters/1
      def update
        if @roster.update(roster_params)
          render json: @roster
        else
          render json: @roster.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /rosters/1/update_slot
      def update_slot
        @roster.template[params[:slot_id].to_s]['ch_class'] = params[:ch_class] if params[:ch_class].present?
        @roster.template[params[:slot_id].to_s]['role'] = params[:role] if params[:role].present?
        @roster.template[params[:slot_id].to_s]['goal'] = params[:goal] if params[:goal].present?

        existing_char = CharacterRosterRole.find_by(roster_id: @roster.id, slot_id: params[:slot_id])
        if existing_char.present? && @roster.template[params[:slot_id].to_s]['character_id'] != params[:character_id]
          existing_char.destroy
        end
        if existing_char.present? && (existing_char.character.roles.include?(@roster.template[params[:slot_id].to_s]['role']) || @roster.template[params[:slot_id].to_s]['ch_class'] != existing_char.character.ch_class)
          existing_char.destroy
          @roster.template[params[:slot_id].to_s]['character_id'] = nil
        end
        if existing_char.nil? && params[:character_id].present?
          new_char = CharacterRosterRole.create!(
            character_id: params[:character_id],
            slot_id: params[:slot_id],
            roster_id: @roster.id
          )
          @roster.template[params[:slot_id].to_s]['character_id'] = new_char.character_id
        end

        if @roster.save
          render json: @roster
        else
          render json: @roster.errors, status: :unprocessable_entity
        end
      rescue ActiveRecord::RecordInvalid => e
        render json: { message: e }, status: :unprocessable_entity
      end

      # DELETE /rosters/1
      def destroy
        @roster.destroy
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_roster
        @roster = Roster.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def roster_params
        params.require(:roster).permit(:name)
      end
    end
  end
end
