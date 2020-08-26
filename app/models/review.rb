class Review < ApplicationRecord
  belongs_to :shelter

  validates_presence_of :title
  validates_presence_of :rating
  validates_presence_of :content
  validates_presence_of :image
  # validates_presence_of :image, allow_nil => true
end
