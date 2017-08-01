class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    #install_extension_path
    socify.root_path
  end

end
