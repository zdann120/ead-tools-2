# == Schema Information
#
# Table name: appointments
#
#  canceled           :boolean          default(FALSE)
#  comments           :text
#  created_at         :datetime         not null
#  id                 :integer          not null, primary key
#  requested_datetime :datetime         not null
#  status             :integer
#  token              :string
#  updated_at         :datetime         not null
#  user_id            :integer
#
# Indexes
#
#  index_appointments_on_token    (token) UNIQUE
#  index_appointments_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class Appointment < ApplicationRecord
  include AASM

  belongs_to :user

  has_secure_token

  enum status: [:pending_approval, :approved, :denied, :canceled, :rescheduled, :no_show, :completed]

  attribute :email, :string

  aasm column: :status, enum: true do
    state :pending_approval, initial: true
    state :approved, :denied, :canceled, :rescheduled, :no_show, :completed

    event :approve do
      transitions from: :pending_approval, to: :approved
    end

    event :deny do
      transitions from: :pending_approval, to: :denied
    end

    event :cancel do
      transitions from: [:pending_approval, :approved], to: :canceled
    end

    event :mark_complete do
      transitions from: :approved, to: :completed
    end

    event :mark_no_show do
      transitions from: :approved, to: :no_show
    end
  end

  def to_param
    token
  end

  def self.find(token)
    where(token: token).first
  end

  private

  def set_default_status
    self.status = :pending_approval
  end
end
