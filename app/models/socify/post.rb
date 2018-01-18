# Copyright (c) 2015, @sudharti(Sudharsanan Muralidharan)
# Socify is an Open source Social network written in Ruby on Rails This file is licensed
# under GNU GPL v2 or later. See the LICENSE.

require_dependency "socify/concerns/shared/callbacks"

module Socify
  class Post < ApplicationRecord
    include Socify::Shared::Callbacks
    #include Shared::Callbacks

    belongs_to :user
    counter_culture :user, column_name: "posts_count"
    acts_as_votable
    acts_as_commentable

    include PublicActivity::Model
    tracked only: [:create, :like], owner: proc { |_controller, model| model.user }

    mount_uploader :attachment, Socify::AvatarUploader

    validates_presence_of :content
    validates_presence_of :user

    auto_html_for :content do
      image
      youtube(width: 400, height: 250, autoplay: false)
      link target: '_blank', rel: 'nofollow'
      simple_format
    end
  end
end
