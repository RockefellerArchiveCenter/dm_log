class DmItem < ApplicationRecord
  
  validates_presence_of :auto_id
  
  validates_presence_of :refid
  
  validates_presence_of :format
  
  validates_presence_of :status
  
  scope :sorted, lambda { order("dm_items.created_at ASC") }
end
