# Preview all emails at http://localhost:3000/rails/mailers/appointments_mailer
class AppointmentsMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/appointments_mailer/new_appointment_request
  def new_appointment_request
    AppointmentsMailer.new_appointment_request
  end

  # Preview this email at http://localhost:3000/rails/mailers/appointments_mailer/new_account_through_express
  def new_account_through_express
    AppointmentsMailer.new_account_through_express
  end

end
