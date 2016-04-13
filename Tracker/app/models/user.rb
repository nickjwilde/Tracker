require 'UserAuth.rb'
require 'factory.rb'

class User < ActiveRecord::Base
  def new
  end
  @email = ""

  def get_email
    @email
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      worker = Factory.new
      worker.connect_to_db("nitrous","","postgres")
      temp_user = UserAuth.new
      temp_user.set_user_id(user.uid)
      authenticate = worker.interact_with_user("V",temp_user)
      if(authenticate == TRUE)
        user.save!
      else
        return FALSE
      end
    end
  end
end
