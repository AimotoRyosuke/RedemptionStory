class ApplicationController < ActionController::Base
  before_action :basic_auth, if: proc{Rails.env.production?}
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def  configure_permitted_parameters
    if devise_parameter_sanitizer.instance_values.values[1][:action] == "create" && devise_parameter_sanitizer.instance_values.values[1][:controller] == "devise/registrations"
      birthday = devise_parameter_sanitizer.instance_values.values[1][:user]['birthday(1i)'] + "%02d" % devise_parameter_sanitizer.instance_values.values[1][:user]['birthday(2i)'].to_i + "%02d" % devise_parameter_sanitizer.instance_values.values[1][:user]['birthday(3i)'].to_i
      devise_parameter_sanitizer.instance_values.values[1][:user][:birthday] = birthday
      devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :gender, :birthday, :image])
    elsif devise_parameter_sanitizer.instance_values.values[1][:action] == "update" && devise_parameter_sanitizer.instance_values.values[1][:controller] == "devise/registrations"
      birthday = devise_parameter_sanitizer.instance_values.values[1][:user]['birthday(1i)'] + "%02d" % devise_parameter_sanitizer.instance_values.values[1][:user]['birthday(2i)'].to_i + "%02d" % devise_parameter_sanitizer.instance_values.values[1][:user]['birthday(3i)'].to_i
      devise_parameter_sanitizer.instance_values.values[1][:user][:birthday] = birthday
      devise_parameter_sanitizer.permit(:account_update, keys: [:nickname, :gender, :birthday, :image])
    end
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == Rails.application.credentials.basic_auth[:username] && password == Rails.application.credentials.basic_auth[:password]
    end
  end

  def authenticate_user!(opts={})
    if user_signed_in?
      super
    else
      redirect_to new_user_session_path
    end
  end
end
