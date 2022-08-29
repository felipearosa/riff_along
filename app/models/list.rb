class List < ApplicationRecord
  belongs_to :user
  has_many :catalogs
  has_many :videos, through: :catalogs
  has_many :solos, through: :videos
end
