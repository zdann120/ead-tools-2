# == Schema Information
#
# Table name: appointments
#
#  comments       :text
#  created_at     :datetime         not null
#  id             :integer          not null, primary key
#  requested_date :date
#  requested_time :time
#  status         :integer
#  token          :string
#  updated_at     :datetime         not null
#  user_id        :integer
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
  after_create :log_create_action

  belongs_to :user
  has_many :activities, as: :actionable,
    dependent: :destroy

  has_secure_token

  enum status: [:pending_approval, :approved, :denied, :canceled, :rescheduled, :no_show, :completed]

  attribute :email, :string

  aasm column: :status, enum: true do
    state :pending_approval, initial: true
    state :approved, :denied, :canceled, :rescheduled, :no_show, :completed

    after_all_transitions :log_status_change

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

  def log_status_change(current_user=nil)
    comment = "Status change: '#{aasm.from_state}' to '#{aasm.to_state}'"
    activities
      .create(action: aasm.current_event, user_id: current_user.try(:id), comment: comment)
    AppointmentsMailer.status_change(self, aasm.to_state).deliver_now
  end

  def log_create_action
    activities.
      create(action: 'create', user_id: user.id, comment: 'Appointment request created.')
  end

  def set_default_status
    self.status = :pending_approval
  end
end
