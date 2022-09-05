class List < ApplicationRecord
  belongs_to :user
  has_many :catalogs, dependent: :destroy
  has_many :videos, through: :catalogs
  has_many :solos, through: :videos

  validates :name, presence: true
end
