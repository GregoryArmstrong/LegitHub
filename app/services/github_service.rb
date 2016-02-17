require 'net/http'
require 'json'

class GithubService

  attr_reader :connection, :user

  def initialize(user)
    @connection = Faraday.new(url: "https://api.github.com") do |faraday|
      faraday.request :url_encoded
      faraday.response :logger
      faraday.adapter Faraday.default_adapter
    end
    @user = user
  end

  def followers
    parse(connection_settings("users/#{@user.nickname}/followers"))
  end

  def following
    parse(connection_settings("users/#{@user.nickname}/following"))
  end

  def starred
    parse(connection_settings("users/#{@user.nickname}/starred"))
  end

  def recent_commits(user)
    parse(connection.get do |req|
      req.url "users/#{user}/events"
      req.headers["Authorization"] = "token #{@user.token}"
      req.params['per_page'] = 100
    end)
  end

  def following_commits
    list = following.map { |person| person[:login] }
  end

  def organizations(user)
    parse(connection_settings("users/#{user}/orgs"))
  end

  def repositories(user)
    parse(connection_settings("users/#{user}/repos"))
  end

  private

  def parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  def connection_settings(path)
    connection.get do |req|
      req.url path
      req.headers["Authorization"] = "token #{@user.token}"
    end
  end

end
