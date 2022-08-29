class Catalog < ApplicationRecord
  belongs_to :list
  belongs_to :video
end
