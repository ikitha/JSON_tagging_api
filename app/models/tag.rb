class Tag < ActiveRecord::Base
  belongs_to :entity
  validates :name, presence: true
  #don't validate uniqueness because we want to destroy/overwrite all tags per entity
end
