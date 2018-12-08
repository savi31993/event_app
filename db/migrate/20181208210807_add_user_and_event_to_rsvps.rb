class AddUserAndEventToRsvps < ActiveRecord::Migration[5.2]
  def change
    add_reference :rsvps, :user, foreign_key: true
    add_reference :rsvps, :event, foreign_key: true
  end
end
