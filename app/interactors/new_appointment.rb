class NewAppointment < ActiveInteraction::Base
  string :first_name, default: nil
  string :last_name, default: nil
  string :email
  date_time :requested_datetime
  string :comments

  validates :email, :requested_datetime, presence: true

  def execute
    user = set_user(email)
    appointment = user.appointments.new(
      requested_datetime: requested_datetime,
      comments: comments
    )
    if appointment.save
      AppointmentsMailer.new_appointment_request(appointment).deliver_now
      appointment
    else
      errors.add(:appointment, 'cannot be saved')
    end
  end

  private

  def set_user(email)
    if User.exists?(email: email)
      is_new = false
    else
      is_new = true
    end
    password = SecureRandom.uuid
    user = User.
      create_with(password: password, first_name: first_name,
                 last_name: last_name).
      find_or_create_by!(email: email)

    if is_new
      AppointmentsMailer.new_account_through_express(user, password).
        deliver_now
    end
    user
  end

end
