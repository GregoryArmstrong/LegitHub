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
    parse(connection.get do |req|
      req.url "users/#{@user.nickname}/followers"
      req.headers["Authorization"] = "token #{@user.token}"
    end)
  end

  def following
    parse(connection.get do |req|
      req.url "users/#{@user.nickname}/following"
      req.headers["Authorization"] = "token #{@user.token}"
    end)
  end

  def starred
    parse(connection.get do |req|
      req.url "users/#{@user.nickname}/starred"
      req.headers["Authorization"] = "token #{@user.token}"
    end)
  end

  def recent_commits(user)
    parse(connection.get do |req|
      req.url "users/#{user.nickname}/events"
      req.headers["Authorization"] = "token #{@user.token}"
      req.params['per_page'] = 100
    end)
  end

  def follower_commits
    list = followers.map { |person| person[:login] }

    # parse(connection.get do |req|)
  end

  private

  def parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end

end
