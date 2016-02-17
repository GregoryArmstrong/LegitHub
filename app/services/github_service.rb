require 'net/http'
require 'json'

class GithubService

  def get(url: "https://api.github.com", path: path)
    uri = URI(url + path + "/")
    response = NET::HTTP.get_response(uri)
    JSON.parse(response.body)
  end

  def follower_information(user)
    path = "users/#{user}/followers"
    get(path: path)
  end

end
