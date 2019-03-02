class Event < ApplicationRecord
  belongs_to :owner, class_name: "User", foreign_key: "user_id"
  belongs_to :category

  has_many :rsvps
  has_many :users, through: :rsvps
  has_one_attached :image

  validates :name, presence: true
  validates :description, presence: true
  validates :date, presence: true

  validate :image_validation

  geocoded_by :address
  after_validation :geocode, :if => :address_changed?

  def image_validation
    if !image.attached?
      errors[:base] << "Must attach an image!"
    end
  end
end
