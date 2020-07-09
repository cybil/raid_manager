class Roster < ApplicationRecord
  validates :name, :template, presence: true
end
