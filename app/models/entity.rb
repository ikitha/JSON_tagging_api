class Entity < ActiveRecord::Base
  has_many :tags
  validates :entity_type, presence: true
  validates :identifier, presence: true
  accepts_nested_attributes_for :tags

  #create tags for the entity unless that tag already exists
  def create_tags(tags)
    tags.each do |tag_name|
      self.tags.create!(name: tag_name) unless self.tags.find_by(name: tag_name)
    end
  end
end
