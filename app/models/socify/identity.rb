module Socify
  class Identity < ApplicationRecord
    belongs_to :user
    validates_presence_of :uid, :provider
    validates_uniqueness_of :uid, scope: :provider
    validates_uniqueness_of :provider, scope: :user
  
    def self.find_for_oauth(auth)
      # byebug
      identity = find_or_create_by(uid: auth[:uid], provider: auth[:provider])

      if auth[:credentials] && auth[:credentials][:token]
        identity.token = auth[:credentials][:token]
        identity.expires_at = Time.at(auth[:credentials][:expires_at].to_i).to_datetime if (auth[:credentials][:expires] != "false" && !auth[:credentials][:expires_at].blank?)
        identity.save
      end

      identity
    end
    
    #<OmniAuth::AuthHash credentials=#<OmniAuth::AuthHash expires=true expires_at=1520620741 token="EAAEmxZBmDWJ4BAEbxT9QMo5kbPi56KTsDBZBZCyRItTUxfZCmwenzwmgpXdnG0PEQDwomHxz1HlVetRbuwGOJcmwMkvaIZBm7ktZAkfVIGMctKW1S4T1XfWoU0P2RU8HZBpjoV0Mxg0f7RNODS5e9wTBBTEhM87svMZD"> extra=#<OmniAuth::AuthHash raw_info=#<OmniAuth::AuthHash email="jayrad1976@gmail.com" id="10156098742013060" name="Jason Radice">> info=#<OmniAuth::AuthHash::InfoHash email="jayrad1976@gmail.com" image="http://graph.facebook.com/v2.6/10156098742013060/picture" name="Jason Radice"> provider="facebook" uid="10156098742013060">
  end
end
