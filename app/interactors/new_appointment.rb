class NewAppointment < ActiveInteraction::Base
  string :first_name, default: nil
  string :last_name, default: nil
  string :email
  date_time :requested_datetime
  string :comments

  validates :email, :requested_datetime, presence: true
  validates :first_name, :last_name, presence: true, if: :names_present?

  def execute
    user = set_user(email)
    appointment = user.appointments.new(
      requested_datetime: requested_datetime,
      comments: comments
    )
    if appointment.save
      appointment
    else
      errors.add(:appointment, 'cannot be saved')
    end
  end

  private

  def names_present?
    !User.exists?(email: email)
  end

  def set_user(email)
    user = User.
      create_with(password: SecureRandom.uuid, first_name: first_name,
                 last_name: last_name).
      find_or_create_by!(email: email)
    user
  end
end
