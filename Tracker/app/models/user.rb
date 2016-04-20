require 'UserAuth.rb'
require 'factory.rb'

class User < ActiveRecord::Base

  # This is a User model for google authentication
 def self.from_omniauth(auth)
    where(uid: auth.uid, provider: auth.provider).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.email = auth.info.email
      user.oauth_token = auth.credentials.token
      user.oauth_token_expires_at = Time.at(auth.credentials.expires_at)
      worker = Factory.new
      worker.connect_to_db("nitrous","","postgres")
      temp_user = UserAuth.new
      temp_user.set_user_id(user.uid)
      temp_user.set_email(user.email)
      authenticate = worker.interact_with_user("V",temp_user)
      if(authenticate == TRUE)
        user.save!
      else
        return FALSE
      end
    end
  end
end
