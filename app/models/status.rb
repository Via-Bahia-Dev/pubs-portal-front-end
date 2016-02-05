class Status < ActiveRecord::Base
  validates_presence_of :name, :color, :order

  default_scope { order(order: :asc) }
end
