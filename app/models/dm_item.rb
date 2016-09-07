class DmItem < ApplicationRecord
  scope :sorted, lambda { order("dm_items.created_at ASC") }
end
