class Comment < ActiveRecord::Base
	validates_presence_of :user_id, :publication_request_id, :date, :content

	belongs_to :publication_request
	belongs_to :user
end
