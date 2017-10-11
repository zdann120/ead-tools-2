class Express::AppointmentsController < ApplicationController
  def new
    @appointment = NewAppointment.new
  end

  def create
    @outcome = NewAppointment.run(appointment_params)
    if @outcome.valid?
      redirect_to @outcome.result
    else
      @appointment = @outcome
      render :new
    end
  end

  private

  def appointment_params
    params.
      require(:new_appointment).
      permit(:requested_datetime, :comments, :email)
  end
end
