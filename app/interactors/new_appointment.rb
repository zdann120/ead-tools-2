class NewAppointment < ActiveInteraction::Base
  string :first_name, default: nil
  string :last_name, default: nil
  string :email
  date :requested_date
  time :requested_time
  string :comments

  validates :email, :requested_date, :requested_time, presence: true

  def execute
    user = set_user(email)
    appointment = user.appointments.new(
      requested_date: requested_date,
      requested_time: requested_time,
      comments: comments
    )
    if appointment.save
      AppointmentsMailer.new_appointment_request(appointment).deliver_now
      AppointmentsMailer.admin_approve_appointment(appointment).deliver_now
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
