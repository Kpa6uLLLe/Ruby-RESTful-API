class Request < ApplicationRecord
  belongs_to :patient
  validates :requestBody, :presence => true
end
