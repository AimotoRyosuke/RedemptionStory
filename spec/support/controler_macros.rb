module ControllerMacros
  def log_in(user)
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in user
  end

  def log_out(user)
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_out user
  end


  private

end