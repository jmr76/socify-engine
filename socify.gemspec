$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "socify/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "socify"
  s.version     = Socify::VERSION
  s.authors     = ["Jason Radice"]
  s.email       = ["jason.radice@affectiva.com"]
  s.homepage    = "http://www.example.com"
  s.summary     = "Socify Engine"
  s.description = "Description of Socify Engine"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.1.2"

  s.add_dependency 'sass-rails', '~> 5.0.0'

  s.add_dependency 'devise'  
  s.add_dependency 'omniauth'
  s.add_dependency 'omniauth-google-oauth2'
  s.add_dependency 'omniauth-twitter'
  s.add_dependency 'omniauth-facebook'

  s.add_dependency 'carrierwave'
  s.add_dependency 'friendly_id', '~> 5.0'
  
  s.add_dependency 'will_paginate', '~> 3.1.0'
  s.add_dependency "public_activity"
  
  s.add_dependency 'acts_as_votable', '~> 0.10.0'
  s.add_dependency 'acts_as_commentable'  
  s.add_dependency 'acts_as_follower'
  s.add_dependency 'counter_culture', '~> 0.1.33'

  s.add_dependency 'auto_html', '~>1.6.4'

  s.add_dependency 'jquery-rails'
  # Used to implement at.js for auto complete mentions/emojis
  s.add_dependency 'jquery-atwho-rails'
  
  s.add_dependency 'bootstrap-sass', '~> 3.2.0'
  s.add_dependency 'font-awesome-rails'
  s.add_dependency 'merit'

  s.add_development_dependency "mysql2"
  
end
