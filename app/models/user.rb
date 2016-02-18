class User < ActiveRecord::Base

  def self.find_or_create_by_auth(auth)
    user = User.find_or_create_by(provider: auth["provider"], uid: auth["uid"])
    binding.pry
    user.name = auth["info"]["name"]
    user.nickname = auth["info"]["nickname"]
    user.email = auth["info"]["email"]
    user.image_url = auth["info"]["image"]
    user.token = auth["credentials"]["token"]
    user.save
    user
  end

end
