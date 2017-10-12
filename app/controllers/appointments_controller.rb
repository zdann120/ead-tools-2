class AppointmentsController < ApplicationController
  before_action :redirect_if_logged_out, unless: :current_user, only: :index
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_appointment, only: [:show, :cancel]

  # GET /appointments
  def index
    @appointments = current_user.appointments
  end

  # GET /appointments/1
  def show
  end

  # GET /appointments/new
  def new
    @appointment = current_user.appointments.new
  end

  # POST /appointments
  def create
    @appointment = current_user.appointments.new(appointment_params)

    if @appointment.save
      redirect_to @appointment, notice: 'Appointment was successfully created.'
    else
      render :new
    end
  end

  def cancel
    if @appointment.cancel!
      redirect_to @appointment
    else
      redirect_to @appointment, alert: 'Sorry, there was a problem canceling this appointment.'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_appointment
      @appointment = Appointment.find(params[:id]).decorate
    end

    # Only allow a trusted parameter "white list" through.
    def appointment_params
      params.require(:appointment).permit(:requested_datetime, :comments)
    end

    def redirect_if_logged_out
      redirect_to new_express_appointment_url
    end
end
