class ApplicationController < ActionController::Base
 # Prevent CSRF attacks by raising an exception.
 # For APIs, you may want to use :null_session instead.
 protect_from_forgery with: :exception
 before_filter :redirect_with_www
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

  def redirect_with_www
    if request.get? && not_allow_protocol_and_subdomain?
      #redirect_to request.protocol + request.host.sub!('', 'www.') + request.path and return
      redirect_to request.protocol + request.host.sub!('', 'www.') + request.path + "?" +request.query_string and return
    end
  end

  def not_allow_protocol_and_subdomain?
    return false if Rails.env.to_s === 'development'
    request.subdomains.blank? 
  end
  
protected

 def configure_permitted_parameters
   devise_parameter_sanitizer.for(:sign_up) << :name
   devise_parameter_sanitizer.for(:account_update) << :name
   devise_parameter_sanitizer.for(:sign_up) << :url
   devise_parameter_sanitizer.for(:account_update) << :url
 end
 
end
