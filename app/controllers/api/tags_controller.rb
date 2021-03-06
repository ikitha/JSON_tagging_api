module API
  class TagsController < ApplicationController
    before_action :find_entity, only: [:entity, :entity_stats, :destroy]
    # get 'stats/:type/:identifier', to: 'tags#entity_stats'
    # get 'tags/:type/:identifier', to: 'tags#entity'
    # get '/stats', to: 'tags#stats'
    # post 'tags', to: 'tags#create'
    # delete 'tags/:type/:identifier', to: 'tags#destroy'

    def create
        @entity = Entity.find_or_create_by(entity_type: tag_params[:entity_type].downcase, identifier: tag_params[:entity_identifier].downcase)
        if @entity.tags.count > 0
          @entity.destroy_all_tags
        end
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
      respond_to do |format|
        format.json { render json: { entity_type: @entity.entity_type, entity_identifier: @entity.identifier, tags: @entity.tags }, status: :ok }
      end
    end

    def entity_stats
      respond_to do |format|
        format.json { render json: { entity_type: @entity.entity_type, entity_identifier: @entity.identifier, tags: @entity.tags, tag_stats: @entity.single_tag_stats }, status: :ok }
      end
    end

    def stats
      respond_to do |format|
        format.json { render json: Tag.all_tag_stats, status: :ok }
      end
    end

    def destroy
      @entity.destroy_all_tags
      @entity.destroy
      respond_to do |format|
        format.json { head :no_content }
      end
    end

  private
    # white list params
    def tag_params
      params.permit(:entity_type, :entity_identifier, tags: [])
    end

    def find_entity
      unless @entity = Entity.find_by(entity_type: tag_params[:entity_type].downcase, identifier: tag_params[:entity_identifier].downcase)
        record_not_found
      end
    end

    def record_not_found
      render text: "404 - Record Not Found", status: :not_found
    end
  end
end