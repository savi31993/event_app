class Category < ApplicationRecord
  has_many :events, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true
end
