class Character < ApplicationRecord
  belongs_to :user

  validates :name, :race, :ch_class, presence: true
end
