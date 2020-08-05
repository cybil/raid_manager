module Api
  module V1
    class BasicComposController < ApplicationController
      before_action :set_basic_compo, only: [:show, :update, :destroy, :update_slot]

      # GET /basic_compos
      def index
        @basic_compos = BasicCompo.all

        render json: @basic_compos
      end

      # GET /basic_compos/1
      def show
        render json: @basic_compo
      end

      # POST /basic_compos
      def create
        @basic_compo = BasicCompo.new(basic_compo_params)

        setup_template params[:size].to_i
        if @basic_compo.save
          render json: @basic_compo, status: :created
        else
          render json: @basic_compo.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /basic_compos/1
      def update
        if @basic_compo.update(basic_compo_params)
          render json: @basic_compo
        else
          render json: @basic_compo.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /basic_compos/1/update_slot
      def update_slot
        @basic_compo.template[params[:slot_id].to_s]['ch_class'] = params[:ch_class] if params[:ch_class].present?
        @basic_compo.template[params[:slot_id].to_s]['role'] = params[:role] if params[:role].present?
        @basic_compo.template[params[:slot_id].to_s]['goal'] = params[:goal].presence || @basic_compo.template[params[:slot_id].to_s]['role']

        if @basic_compo.save
          render json: @basic_compo
        else
          render json: @basic_compo.errors, status: :unprocessable_entity
        end
      end

      # DELETE /basic_compos/1
      def destroy
        @basic_compo.destroy
      end

      private

      def setup_template(size)
        size.times do |index|
          @basic_compo.template[index] = {
            id: index,
            role: 'tank',
            goal: 'mt',
            ch_class: 'warrior',
            character_id: nil
          }
        end
      end

      # Use callbacks to share common setup or constraints between actions.
      def set_basic_compo
        @basic_compo = BasicCompo.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def basic_compo_params
        params.require(:basic_compo).permit(:name)
      end
    end
  end
end
