class Catalog < ApplicationRecord
  belongs_to :list
  belongs_to :video

  validates :list, presence: true, allow_blank: false
end
