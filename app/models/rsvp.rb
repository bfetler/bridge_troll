class Rsvp < ActiveRecord::Base
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :user
  belongs_to :event
  has_many :rsvp_sessions

  validates_uniqueness_of :user_id, scope: :event_id
  validates_presence_of :user, :event, :role
  belongs_to_active_hash :role
  belongs_to_active_hash :volunteer_assignment

  def formatted_preference
    if teaching
      if taing
        'Teaching or TAing'
      else
        'Teaching'
      end
    elsif taing
      'TAing'
    else
      'No Preference'
    end
  end

  def set_attending_sessions session_ids
    rsvp_sessions.destroy_all
    session_ids.each do |session_id|
      rsvp_sessions.create(event_session_id: session_id)
    end
  end
end
