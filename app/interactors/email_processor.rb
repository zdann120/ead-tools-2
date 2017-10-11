class EmailProcessor
  def initialize(email)
    @email = email
  end

  def process
    if @email.from[:email] == 'zach@zdnenterprises.com'
      appointment = Appointment.find_by_token(@email.subject)
      return unless appointment
      case @email.body
      when 'approve'
        appointment.approve!
      end
    end
  end
end
