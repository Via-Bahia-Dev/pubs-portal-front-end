class Template < ActiveRecord::Base
	validates_presence_of :name, :user_id, :dimensions

	has_attached_file :image, styles: { large: "x500>", medium: "x300>", small: "x100>", thumb: "50x50#" }
	validates_attachment_presence :image
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  validates_attachment_file_name :image, matches: [/png\Z/, /jpe?g\Z/, /gif\Z/]

	belongs_to :user
end
