class Recommendation < ApplicationRecord
  belongs_to :request
  validates :request, :presence => true
end
