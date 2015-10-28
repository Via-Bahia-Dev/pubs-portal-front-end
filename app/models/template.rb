class Template < ActiveRecord::Base
	validates_presence_of :name, :user_id, :dimensions

	belongs_to :user
end
