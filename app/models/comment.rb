class Comment < ActiveRecord::Base
	validates_presence_of :user_id, :publication_request_id, :content

	belongs_to :publication_request
	belongs_to :user

	default_scope { order(created_at: :desc) }
end
