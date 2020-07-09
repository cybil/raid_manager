class CharacterRosterRole < ApplicationRecord
  belongs_to :character
  belongs_to :roster

  validates :slot_id, :roster_id, presence: true
  validates :character_id, uniqueness: { scope: :roster_id }

  after_commit :update_roster_template

  private

  def update_roster_template
    roster.template[slot_id.to_s]['character_id'] = character_id
    roster.save!
  end
end
