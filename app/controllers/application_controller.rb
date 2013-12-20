class ApplicationController < ActionController::Base
 # Prevent CSRF attacks by raising an exception.
 # For APIs, you may want to use :null_session instead.
 protect_from_forgery with: :exception
 
 before_filter :configure_permitted_parameters, if: :devise_controller?

  def login_via_super_admin
    user = User.find_by_id(params[:id])
    
    if user.present?
      flash[:notice] = "Signed in successfully."
      sign_in_and_redirect(:user, user)
    else
      flash[:error] = "Error while login, please try again"
      redirect_to(:back)
    end
  end

protected

 def configure_permitted_parameters
   devise_parameter_sanitizer.for(:sign_up) << :name
   devise_parameter_sanitizer.for(:account_update) << :name
   devise_parameter_sanitizer.for(:sign_up) << :url
   devise_parameter_sanitizer.for(:account_update) << :url
 end
 
end
