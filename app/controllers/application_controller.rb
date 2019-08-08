class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  
  def after_sign_in_path_for(resource)
    if current_user.present? && current_user.admin? 
      admin_libraries_path
    elsif current_user.present? && current_user.library_owner?
      library_owner_libraries_path
    else 
      root_path
    end
  end

end
