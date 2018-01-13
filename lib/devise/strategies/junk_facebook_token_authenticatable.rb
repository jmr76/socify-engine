# require 'devise/strategies/authenticatable'
# 
# puts "MY AUTHENTICABLE INITIALIZER"
# 
# module Devise
#   module Strategies
#     class FacebookTokenAuthenticatable < Authenticatable
#       def valid?
#         byebug
#         puts "HERE!!! FACEBOOKTOKENAUTH"
#         false
#       end
# 
#       def authenticate!
#         byebug
#         puts "FACEBOOK TOKEN AUTHENTICATE!!!!"
#       end
#     end
#   end
# end
# 
# Warden::Strategies.add(:facebook_token_authenticatable, Devise::Strategies::FacebookTokenAuthenticatable)
# #Devise.add_module :facebook_token_authenticatable, :strategy => true