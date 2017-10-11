class Express::AppointmentsController < ApplicationController
  def authenticate
    @user = current_user
    if @user
      session[:email] = nil
      redirect_to new_express_appointment_url
    else
      @user = User.find_by_email(params[:user][:email])
      session[:email] = params[:user][:email]
      redirect_to new_express_appointment_url
    end
  end

  def clear_session_email
    session[:email] = nil
    redirect_to new_express_appointment_url
  end

  def new
    @appointment = NewAppointment.new
    @email = current_user.try(:email)
    @email ||= session[:email]
    @user_exists = User.exists?(email: @email)
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
      permit(:requested_datetime, :comments, :email, :first_name, :last_name)
  end
end
