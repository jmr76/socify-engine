# Copyright (c) 2015, @sudharti(Sudharsanan Muralidharan)
# Socify is an Open source Social network written in Ruby on Rails This file is licensed
# under GNU GPL v2 or later. See the LICENSE.

require_dependency "socify/concerns/shared/callbacks"

module Socify
  class User < ApplicationRecord
    # Include default devise modules. Others available are:
    has_merit
    attr_accessor :login

    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :omniauthable

    acts_as_voter
    acts_as_follower
    acts_as_followable


    has_many :posts
    has_many :comments
    has_many :events
    has_many :identities

    mount_uploader :avatar, AvatarUploader
    mount_uploader :cover, AvatarUploader

    validates_presence_of :name

    validates :username, :presence => true,
    :uniqueness => {
      :case_sensitive => false
    }

    self.per_page = 10

    extend FriendlyId
    friendly_id :name, use: [:slugged, :finders]

    TEMP_EMAIL_PREFIX = 'change@me'
    TEMP_EMAIL_REGEX = /\Achange@me/
  
    validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update
  
    def self.find_for_oauth(auth, signed_in_resource = nil)

      # Get the identity and user if they exist
      identity = Identity.find_for_oauth(auth)
  
      # If a signed_in_resource is provided it always overrides the existing user
      # to prevent the identity being locked with accidentally created accounts.
      # Note that this may leave zombie accounts (with no associated identity) which
      # can be cleaned up at a later date.
      user = signed_in_resource ? signed_in_resource : identity.user
  
      # Create the user if needed
      if user.nil?
  
        # Get the existing user by email if the provider gives us a verified email.
        # If no verified email was provided we assign a temporary email and ask the
        # user to verify it on the next step via UsersController.finish_signup
        # if auth.provider == 'google_oauth2'
        email = auth.info.email || "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com"
        # else
        #   email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
        #   email = auth.info.email if email_is_verified
        # end
        user = Socify::User.where(:email => email).first if email

        # Create the user if it's a new registration
        if user.nil?
          user = Socify::User.new(
            name: auth.info.name,
            username: auth.info.nickname || email,
            email: email,
            password: Devise.friendly_token[0,20],
            token: auth.credentials.token,
            secret: auth.credentials.secret
          )
          # user.skip_confirmation!
          user.save!
        end
      else
        user.update(
          token: auth.credentials.token,
          secret: auth.credentials.secret
        )
        user.save!
      end
  
      # Associate the identity with the user if needed
      if identity.user != user
        identity.user = user
        identity.save!
      end
      user
    end
  
    def email_verified?
      self.email && self.email !~ TEMP_EMAIL_REGEX
    end

    def self.find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
      elsif conditions.has_key?(:username) || conditions.has_key?(:email)
        where(conditions.to_h).first
      end
    end
  end
end