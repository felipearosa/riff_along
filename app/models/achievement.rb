class Achievement < ApplicationRecord
  has_many :podiums
  has_many :users, through: :podiums
end
