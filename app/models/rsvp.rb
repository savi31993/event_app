class Rsvp < ApplicationRecord
  belongs_to :user
  belongs_to :event

  scope :going, -> {where(:status => true)}
  scope :not_going,-> {where(:status => false)}
end
