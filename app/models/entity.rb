class Entity < ActiveRecord::Base
  has_many :tags
  validates :entity_type, presence: true
  validates :identifier, presence: true
  accepts_nested_attributes_for :tags

  #create tags for the entity unless that tag already exists
  def create_tags(tags)
    tags.each do |tag_name|
      self.tags.create!(name: tag_name.downcase) unless self.tags.find_by(name: tag_name.downcase)
    end
  end

  def single_tag_stats
    tags = self.tags.pluck(:name)
    stats = tags.map { |tag| { name: tag , total_occurence: Tag.where(name: tag.downcase).count } }
    stats
  end

  def destroy_all_tags
    self.tags.each do |single_tag|
      tag = tags.where(name: single_tag.name.downcase).first
      tag.destroy
    end
  end
end
