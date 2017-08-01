require "devise"
require "carrierwave"
require "will_paginate"

require "friendly_id"

require "acts_as_follower"
require "acts_as_votable"
require "acts_as_commentable"

require "auto_html"

require "counter_culture"
require "merit"

require "public_activity"

require 'jquery-rails'
require 'jquery-atwho-rails'

require "sass-rails"
require "bootstrap-sass"
require "font-awesome-rails"


module Socify
  class Engine < ::Rails::Engine
    isolate_namespace Socify
    config.to_prepare do
      Devise::SessionsController.layout "socify/application"
    end
  end
end
