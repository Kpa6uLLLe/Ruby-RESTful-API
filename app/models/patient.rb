class Patient < ApplicationRecord
  has_many :request
  validates :email, :presence => true
  validates :phone, :presence => true
  validates :initials, :presence => true
  validates :birthdate, :presence => true
end
