class Pet < ApplicationRecord
  belongs_to :shelter
  has_many :favorites
  has_many :apply

  validates_presence_of :image
  validates_presence_of :name
  validates_presence_of :approximate_age
  validates_presence_of :sex
end
