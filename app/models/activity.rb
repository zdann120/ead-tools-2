# == Schema Information
#
# Table name: activities
#
#  action          :string           not null
#  actionable_id   :integer
#  actionable_type :string
#  comment         :text
#  created_at      :datetime         not null
#  id              :integer          not null, primary key
#  updated_at      :datetime         not null
#  user_id         :integer
#  uuid            :uuid             not null
#
# Indexes
#
#  index_activities_on_actionable_type_and_actionable_id  (actionable_type,actionable_id)
#  index_activities_on_user_id                            (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class Activity < ApplicationRecord
  belongs_to :actionable, polymorphic: true
  belongs_to :user, required: false

  before_create :set_uuid

  private

  def set_uuid
    self.uuid = SecureRandom.uuid
  end
end
