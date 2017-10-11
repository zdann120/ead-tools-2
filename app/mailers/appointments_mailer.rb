class AppointmentsMailer < ApplicationMailer
  add_template_helper ApplicationHelper

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

  def admin_approve_appointment(appointment)
    @appointment = appointment
    mail to: 'zach@zdnenterprises.com',
      subject: 'new appointment request',
      from: 'appointments@euroamerica.design'
  end

  def status_change(appointment, status = nil)
    @appointment = appointment
    @status = status
    mail to: appointment.user.email,
      subject: 'Update: Your appointment at EuroAmerica Design',
      from: '"EuroAmerica Design" <appointments@euroamerica.design>',
      bcc: 'zdnenterprises@gmail.com'
  end
end
