class Tagging < ActiveRecord::Base
  belongs_to :template
  belongs_to :tag
end
