class Caregiver < ApplicationRecord
  validates :name, presence: true

  has_many :walkings
end
