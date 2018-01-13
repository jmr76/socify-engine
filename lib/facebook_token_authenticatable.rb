module FacebookTokenAuthenticatable
  class FacebookTokenStrategy < Devise::Strategies::Authenticatable
    def store?
      false
    end

    def valid?
      # must call this to actually get the authentication_hash set:
      # valid_for_http_auth?

      # but, we want this strategy to be valid for any request with this header set so that we can use a custom
      # response for an invalid request.
      puts "CUSTOM VALID??????"
      valid = request.headers['X-HC-FB-AUTH'].present?
      puts "FB Auth header? #{valid}"
      valid
    end

    # it must have an authenticate! method to perform the validation
    # a successful request calls `success!` with a user object to stop
    # other strategies and set up the session state for the user logged in
    # with that user object.
    def authenticate!

      # mapping comes from devise base class, "mapping.to" is the class of the model
      # being used for authentication, typically the class "User". This is set by using
      # the `devise` class method in that model
      #byebug
      klass = mapping.to

      if request.headers['X-HC-FB-AUTH'].present?
        # the returned user object will be saved and serialised into the session

        decoded = Base64.decode64(request.headers['X-HC-FB-AUTH'])
        user_and_token = decoded.split(':')

        users = klass.includes(:identities).where(socify_identities: { uid: user_and_token[0], token: user_and_token[1], provider: "facebook"})
        begin
          if users.size == 1
            u = users.first
            identity = u.identities.find_by!(uid: user_and_token[0], token: user_and_token[1], provider: "facebook")
            if !identity.expires_at || (identity.expires_at && identity.expires_at > Time.now)
              success! u
            else
              fail! "token expired"
            end
          else
            fail! "invalid uid and/or token"
          end
        rescue
          fail!
        end
      end

      # if we wanted to stop other strategies from authenticating the user
    end
  end
end

# for warden, `:my_authentication`` is just a name to identify the strategy
Warden::Strategies.add :facebook_token_authenticatable, FacebookTokenAuthenticatable::FacebookTokenStrategy

# for devise, there must be a module named 'MyAuthentication' (name.to_s.classify), and then it looks to warden
# for that strategy. This strategy will only be enabled for models using devise and `:my_authentication` as an
# option in the `devise` class method within the model.
Devise.add_module :facebook_token_authenticatable, :strategy => true