class Event < ApplicationRecord
  belongs_to :owner, class_name: "User", foreign_key: "user_id"
  belongs_to :category

  has_many :rsvps
  has_many :users, through: :rsvps


  validates :name, presence: true
  validates :description, presence: true
end
