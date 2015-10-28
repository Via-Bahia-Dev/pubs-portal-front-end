class PublicationRequest < ActiveRecord::Base
	validates_presence_of :event, :description, :rough_date, :due_date, :event_date, :user_id, :dimensions, :admin_id, :designer_id, :reviewer_id, :status

	belongs_to :user
	has_many :request_attachments
	belongs_to :admin, :class_name => 'User', :foreign_key => 'admin_id'
  belongs_to :designer, :class_name => 'User', :foreign_key => 'designer_id'
  belongs_to :reviewer, :class_name => 'User', :foreign_key => 'reviewer_id'
	has_many :comments
end
