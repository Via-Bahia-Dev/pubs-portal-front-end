class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :templates, through: :taggings

  validates_presence_of :name
end
