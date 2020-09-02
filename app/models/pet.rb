class Pet < ApplicationRecord
  belongs_to :shelter
  has_many :favorites
  has_many :pet_apply
  has_many :applys, through: :pet_apply, dependent: :destroy

  validates_presence_of :image
  validates_presence_of :name
  validates_presence_of :approximate_age
  validates_presence_of :sex
end
