class Achievement < ApplicationRecord
  has_many :podia
  has_many :users, through: :podia
end
