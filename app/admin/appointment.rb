ActiveAdmin.register Appointment do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
  permit_params do
    permitted = [:user_id, :requested_datetime, :comments]
    permitted << :other if params[:action] == 'create' && current_user.admin?
    permitted
  end

  index do
    selectable_column
    column :requested_datetime
    column :user
    column :comments
    column :status
    actions
  end

  form do |f|
    inputs 'User' do
      input :user
    end

    inputs 'Appointment' do
      input :requested_date
      input :requested_time
      input :comments
    end

    actions
  end

  show do
    h3 "Appointment ID: "+ appointment.token
    attributes_table do
      row :user
      row :requested_datetime
      row :comments
      row :status do |apt|
        status_tag apt.status
      end
      row :created_at
    end
    h4 "Activity Log"
    table_for appointment.activities do
      column :created_at
      column :action
      column :comment
    end
    h4 "Actions"

  end

  action_item :approve, only: :show do
    link_to 'Approve', approve_admin_appointment_path(appointment), method: :put if appointment.may_approve?
  end

  action_item :deny, only: :show do
    link_to 'Deny', deny_admin_appointment_path(appointment), method: :put  if appointment.may_deny?
  end

  action_item :cancel, only: :show do
    link_to 'Cancel', cancel_admin_appointment_path(appointment), method: :put  if appointment.may_cancel?
  end

  action_item :mark_no_show, only: :show do
    link_to 'No Show', mark_no_show_admin_appointment_path(appointment), method: :put  if appointment.may_mark_no_show?
  end

  [:approve, :deny, :cancel, :mark_no_show, :complete].each do |status|
    member_action status, method: :put do
      status_bang = "#{status}!".to_sym
      resource.try(status_bang)
      redirect_to resource_path, notice: "Success!"
    end
  end

end
