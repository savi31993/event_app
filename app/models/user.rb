class User < ApplicationRecord
  has_many :events, dependent: :destroy

  has_many :participated_events, through: :rsvp

  validates :name, presence: true

  EMAIL_FORMAT = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: EMAIL_FORMAT }, uniqueness: true

  before_validation { self.email = email.downcase }

  has_secure_password
end
