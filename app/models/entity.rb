class Entity < ActiveRecord::Base
  validates_presence_of :entity_type, :entity_id, :tags

  def self.get_stats
    @entities = Entity.all.map(&:tags).flatten
    @tag_frequency = @entities.inject(Hash.new(0)) { |h,v| h[v] += 1;h }.collect{|k,v| {tag: k, count: v}}
  end


  def individual_stat
    tags.collect{|k,v| {tag: k, count: 1}}
  end
end
