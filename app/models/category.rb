class Category < ApplicationRecord
  has_many :events, dependent: :destroy
  has_one_attached :image

  validates :name, presence: true
  validates :description, presence: true

  validate :image_validation

  scope :by_name, -> {order(:name)}

  def image_validation
    if !image.attached?
      errors[:base] << "Must attach an image!"
    end
  end
end
