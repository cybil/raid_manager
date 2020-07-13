class User < ApplicationRecord
  has_secure_password

  validates :name, :officer, presence: true
  has_many :characters, class_name: 'Character'
end
