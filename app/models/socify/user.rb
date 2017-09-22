# Copyright (c) 2015, @sudharti(Sudharsanan Muralidharan)
# Socify is an Open source Social network written in Ruby on Rails This file is licensed
# under GNU GPL v2 or later. See the LICENSE.

require_dependency "socify/concerns/shared/callbacks"

module Socify
  class User < ApplicationRecord
    # Include default devise modules. Others available are:
    has_merit

    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable, 
       :recoverable, :rememberable, :trackable, :validatable,
       :omniauthable, omniauth_providers: [:google_oauth2, :facebook, :twitter]
       
    # :confirmable,
       
    acts_as_voter
    acts_as_follower
    acts_as_followable

    has_many :posts
    has_many :comments
    has_many :events

    mount_uploader :avatar, AvatarUploader
    mount_uploader :cover, AvatarUploader

    validates_presence_of :name

    self.per_page = 10

    extend FriendlyId
    friendly_id :name, use: [:slugged, :finders]

    def self.create_from_provider_data(provider_data)
      where(provider: provider_data.provider, uid: provider_data.uid).first_or_create do | user |
        user.email = provider_data.info.email
        user.password = Devise.friendly_token[0, 20]
        user.name = provider_data.info.name
        user.avatar = provider_data.info.image
        user.sex = provider_data.info.gender
        user.skip_confirmation!
      end
    end
  end
end