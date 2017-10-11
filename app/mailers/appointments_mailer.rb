class AppointmentsMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.appointments_mailer.new_appointment_request.subject
  #
  def new_appointment_request(appointment)
    @appointment = appointment

    mail to: appointment.user.email,
      subject: 'EuroAmerica Design: Appointment request received',
      from: 'appointments@euroamerica.design'
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.appointments_mailer.new_account_through_express.subject
  #
  def new_account_through_express(user, password)
    @user = user
    @password = password

    mail to: user.email,
      subject: 'EuroAmerica Design: New account',
      from: 'accounts@euroamerica.design'
  end
end
