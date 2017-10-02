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
    devise :database_authenticatable, :registerable, 
       :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:login]
       
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

    validates :username, :presence => true,
    :uniqueness => {
      :case_sensitive => false
    }

    self.per_page = 10

    extend FriendlyId
    friendly_id :name, use: [:slugged, :finders]

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