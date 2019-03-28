class User < ApplicationRecord
  has_secure_password
  # mount_uploader :avatar, AvatarUploader
  has_many :organisation_members
  has_many :organisations, through: :organisation_members
  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :username, presence: true, uniqueness: true
  validates :password,
            length: { minimum: 6 },
            if: -> { new_record? || !password.nil? }
end
