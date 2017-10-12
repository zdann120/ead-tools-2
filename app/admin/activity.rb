ActiveAdmin.register Activity do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
  permit_params do
    permitted = [:actionable_id, :actionable_type, :action, :comment, :user_id]
    permitted << :other if params[:action] == 'create' && current_user.admin?
    permitted
  end
  form do |f|
    inputs 'Actionable' do
      input :actionable, collection: Appointment.all.map{|a| [a.token, a.id]}
      input :actionable_type, as: :hidden, value: 'Appointment'
    end

    inputs 'Action' do
      input :action
      input :comment
      input :user
    end
    actions
  end

end
