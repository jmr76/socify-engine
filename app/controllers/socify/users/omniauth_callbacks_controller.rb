class Socify::Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def self.provides_callback_for(provider)
    class_eval %Q{
      def #{provider}
        @user = Socify::User.find_for_oauth(request.env['omniauth.auth'].except(:extra), current_user)

        if @user.persisted?
          sign_in_and_redirect @user, event: :authentication
          set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
        else
          session["devise.#{provider}_data"] = request.env['omniauth.auth'].except(:extra)
          redirect_to new_user_registration_url
        end
      end
    }
  end

  [:twitter, :google_oauth2, :facebook].each do |provider|
    provides_callback_for provider
  end

  def after_sign_in_path_for(resource)
    if resource.email_verified?
      if @user.created_at == @user.last_sign_in_at && @user.created_at == @user.current_sign_in_at && @user.last_sign_in_at == @user.current_sign_in_at
        main_app.install_extension_path
      else
        super resource
      end
    else
      finish_signup_path(resource)
    end
  end
end
