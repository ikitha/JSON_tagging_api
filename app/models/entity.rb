class Entity < ActiveRecord::Base
  has_many :tags
  validates :entity_type, presence: true
  validates :identifier, presence: true
  accepts_nested_attributes_for :tags
end
