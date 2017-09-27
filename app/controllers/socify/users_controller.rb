# Copyright (c) 2015, @sudharti(Sudharsanan Muralidharan)
# Socify is an Open source Social network written in Ruby on Rails This file is licensed
# under GNU GPL v2 or later. See the LICENSE.

require_dependency "socify/application_controller"

module Socify
  class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user
    before_action :check_ownership, only: [:edit, :update, :destroy]
    respond_to :html, :js

    def show
      @activities = PublicActivity::Activity.where(owner: @user).order(created_at: :desc).paginate(page: params[:page], per_page: 10)
    end

    def edit
    end

    def update
      if @user.update(user_params)
        redirect_to user_path(@user)
      else
        render :edit
      end
    end

    def deactivate
    end

    def destroy
      if @user.destroy
        redirect_to socify.root_path
      end
    end

    def finish_signup
      # authorize! :update, @user 
      if request.patch? && params[:user] #&& params[:user][:email]
        if @user.update(user_params)
          @user.skip_reconfirmation!
          sign_in(@user, :bypass => true)
          redirect_to @user, notice: 'Your profile was successfully updated.'
        else
          @show_errors = true
        end
      end
    end

    def friends
      #@friends = @user.following_users.paginate(page: params[:page])
      @friends = @user.following_by_type("Socify::User").paginate(page: params[:page])
    end

    def followers
      #@followers = @user.user_followers.paginate(page: params[:page])
      @followers = @user.followers_by_type("Socify::User").paginate(page: params[:page])
    end

    def mentionable
      #render json: @user.following_users.as_json(only: [:id, :name]), root: false
      render json: @user.following_by_type("Socify::User").as_json(only: [:id, :name]), root: false
    end

    private

    def user_params
      params.require(:user).permit(:name, :about, :avatar, :cover,
                                   :sex, :dob, :location, :phone_number)
    end

    def check_ownership
      redirect_to current_user, notice: 'Not Authorized' unless @user == current_user
    end

    def set_user
      @user = User.friendly.find_by(slug: params[:id]) || User.find_by(id: params[:id])
      render_404 and return unless @user
    end
  end
end