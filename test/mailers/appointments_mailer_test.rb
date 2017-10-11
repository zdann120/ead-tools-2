require 'test_helper'

class AppointmentsMailerTest < ActionMailer::TestCase
  test "new_appointment_request" do
    mail = AppointmentsMailer.new_appointment_request
    assert_equal "New appointment request", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "new_account_through_express" do
    mail = AppointmentsMailer.new_account_through_express
    assert_equal "New account through express", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
