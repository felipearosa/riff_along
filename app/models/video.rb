class Video < ApplicationRecord
  has_many :solos
  has_many :catalogs, dependent: :destroy
  has_many :lists, through: :catalogs
  has_many :users, through: :lists
end
