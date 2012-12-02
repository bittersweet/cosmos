class User < ActiveRecord::Base
  devise :rememberable, :trackable

  attr_accessible :email, :remember_me

  def self.create_via_omniauth(auth)
    user = self.new
    user.uid = auth['uid']
    user.name = auth['info']['name']
    user.email = auth['info']['email']
    user.save
  end
end
