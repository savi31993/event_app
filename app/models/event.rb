class Event < ApplicationRecord
  belongs_to :user
  belongs_to :category

  has_many :users, through: :rsvps

  validates :name, presence: true
  validates :description, presence: true
end
