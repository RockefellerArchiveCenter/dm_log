class DmItem < ApplicationRecord
  
  # digital media item must have a unique ID before record can be saved
  validates :auto_id, :presence => true, :uniqueness => true
  
  
  # digital media item must have an ArchivesSpace refid, format, and transfer status before record can be saved
  validates_presence_of :refid
  
  validates_presence_of :format
  
  validates_presence_of :status
  
  # sorts digital media items in order of record creation date
  scope :sorted, lambda { order("dm_items.created_at ASC") }
  
  # filters ArchivesSpace parent resource title by search term (used on index page)
  def self.search(term)
    if term
      where('resource LIKE ? or display_title LIKE ?', "%#{term}%", "%#{term}%")
    else
      all
    end
  end
  
  
end
