class MarkCompletedJob < ApplicationJob
  queue_as :default

  def perform
    @appointments = Appointment.all.
      where(status: :approved).
      where("(requested_datetime + interval '1 hour') < ?", Time.zone.now.to_datetime)

    @appointments.each do |appointment|
      appointment.mark_complete!
    end
  end
end
