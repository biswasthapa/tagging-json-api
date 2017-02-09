class EntitiesController < ApplicationController
  before_action :get_entity, only: [:show, :destroy, :get_individual_stat]


  def show
    if @entity
      render :json => {entity: @entity, result: 'success'}
    else
      render :json => {error: 'Cannot find entity with given details', result: 'failed'}
    end
  end

  def create
    begin
      @entity = Entity.find_or_initialize_by(entity_id: entity_params[:entity_id])


      if @entity.update(entity_type: entity_params[:entity_type], tags: entity_params[:tags].uniq)
        render :json => {entity: @entity, result: 'success'}
      else
        render :json => {errors: @entity.errors, result: 'failed'}
      end
    rescue Exception => e
      render :json => {errors: e.message, result: 'failed'}
    end
  end


  def destroy
    if @entity
      if @entity.destroy
        render :json => {result: 'success'}
      else
        render :json => {errors: @entity.errors, result: 'failed'}
      end
    else
      render :json => {error: 'Cannot find entity with given details', result: 'failed'}
    end
  end

  def stats
    @tag_stats = Entity.get_stats
    unless @tag_stats.empty?
      render :json => {tag_stats: @tag_stats, result: 'success'}
    else
      render :json => {error: 'No entities present', result: 'failed'}
    end
  end

  def get_individual_stat
    if @entity
      render :json => {entity_stat: @entity.individual_stat, result: 'success'}
    else
      render :json => {error: 'Cannot find entity with given details', result: 'failed'}
    end
  end

  private

    def entity_params
      params.require(:entity).permit(:entity_type, :entity_id, tags: [])
    end

    def get_entity
      @entity = Entity.where(entity_type: params[:entity_type], entity_id: params[:entity_id]).first
    end
end
