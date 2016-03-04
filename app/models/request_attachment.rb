class RequestAttachment < ActiveRecord::Base
	belongs_to :publication_request
	belongs_to :user

	has_attached_file :file, styles: lambda { |a| a.instance.check_file_type },
		:url => "/:class/:attachment/:id/:style_:basename.:extension"

	validates_attachment_presence :file
	validates_attachment_content_type :file, content_type: [/\Aimage\/.*\Z/, 'application/x-rar-compressed', 'application/zip', 'application/pdf']
	validates_attachment_file_name :file, matches: [/png\Z/, /jpe?g\Z/, /gif\Z/, /zip\Z/, /rar\Z/, /psd\Z/, /pdf\Z/]

	validates_presence_of :publication_request_id
	validates_presence_of :user_id

	default_scope { order(created_at: :desc) }

	def check_file_type
		if is_image_type?
			{ large: "x500>", medium: "x300>", small: "x100>", large_thumb: "100x100#", thumb: "50x50#" }
		else
			{}
		end
	end

	def is_image_type?
		file.content_type =~ /\Aimage\/.*\Z/
	end

	def request_attachment_urls
		urls = {:thumb => self.file.url(:thumb),:small => self.file.url(:small), :medium => self.file.url(:medium),:large => self.file.url(:large)}
	end

end
