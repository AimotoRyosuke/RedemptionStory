class ApplicationController < ActionController::Base
  before_action :basic_auth, if: proc{Rails.env.production?}
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  def  configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :sex, :image])
  end


  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == Rails.application.credentials.basic_auth[:username] && password == Rails.application.credentials.basic_auth[:password]
    end
  end

end
