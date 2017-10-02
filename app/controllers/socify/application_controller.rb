# Copyright (c) 2015, @sudharti(Sudharsanan Muralidharan)
# Socify is an Open source Social network written in Ruby on Rails This file is licensed
# under GNU GPL v2 or later. See the LICENSE.

module Socify
  class ApplicationController < ActionController::Base
    respond_to :html, :json

    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception

    before_action :configure_permitted_parameters, if: :devise_controller?

    before_action :configure_permitted_parameters, if: :devise_controller?
    
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation) }
    end

    protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :username, :password_confirmation])
      devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :username, :remember_me])
    end

    def render_404
      respond_to do |format|
        format.html { render :file => "#{Rails.root}/public/404", :layout => false, :status => :not_found }
      end
    end

    include PublicActivity::StoreController
    
    private

    # Overwriting the sign_in and sign_out redirect path methods
    def after_sign_in_path_for(resource)
      stored_location_for(resource) || socify.root_path
    end

    def after_sign_out_path_for(resource_or_scope)
      socify.root_path
    end
    
  end
end