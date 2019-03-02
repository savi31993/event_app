class Category < ApplicationRecord
  has_many :events, dependent: :destroy
  has_one_attached :image

  validates :name, presence: true
  validates :description, presence: true
  validates :image, presence: true
  scope :by_name, -> {order(:name)}
end
