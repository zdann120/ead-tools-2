module ApplicationHelper
  def action_message_from_status(status)
    case status
    when 'approved'
      'Your appointment is approved and has been scheduled. Please contact us if you cannot make it.'
    when 'no_show'
      'We have recorded a no-show for this appointment request. This can be avoided by notifying us in advance if you cannot make it.'
    when 'denied'
      'We cannot accomodate an appointment at that time. Please submit another request.'
    when 'canceled'
      'We have processed a cancelation for this appointment. If you have changed your mind, please submit a new request.'
    else
      'Have a great day!'
    end
  end
end
