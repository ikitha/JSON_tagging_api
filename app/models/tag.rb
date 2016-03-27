class Tag < ActiveRecord::Base
  belongs_to :entity
  validates :name, presence: true
  #don't validate uniqueness because we want to destroy/overwrite all tags per entity

  def self.all_tag_stats
    unique_tags = Tag.uniq.pluck(:name)
    stats = unique_tags.map { |tag| { name: tag , count: Tag.where(name: tag).count } }
    stats
  end
end
