module API
  class TagsController < ApplicationController
    before_action :find_entity, only: [:entity, :entity_stats, :destroy]
    # get 'stats/:type/:identifier', to: 'tags#entity_stats'
    # get 'tags/:type/:identifier', to: 'tags#entity'
    # get '/stats', to: 'tags#stats'
    # post 'tags', to: 'tags#create'
    # delete 'tags/:type/:identifier', to: 'tags#destroy'

    def create
        @entity = Entity.create(entity_type: tag_params[:entity_type], identifier: tag_params[:entity_identifier])
        @entity.create_tags(tag_params[:tags])
        respond_to do |format|
          format.json { render json: { entity_type: @entity.entity_type, entity_identifier: @entity.identifier, tags: @entity.tags }, status: :created }
        end
    rescue => e
      respond_to do |format|
        format.json { render json: e.message, status: :unprocessible_entity }
      end
    end

    def entity
    end

    def entity_stats
    end

    def stats
    end

    def destroy
    end

  private
    # white list params
    def tag_params
      params.permit(:entity_type, :entity_identifier, tags: [])
    end

    def find_entity
      unless @entity = Entity.find_by(entity_type: tag_params[:entity_type], identifier: tag_params[:entity_identifier])
        record_not_found
      end
    end

    def record_not_found
      render text: "404 - Record Not Found", status: :not_found
    end
  end
end