class Organisation < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :organisation_members
  has_many :users, through: :organisation_members
end
