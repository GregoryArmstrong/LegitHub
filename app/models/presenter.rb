require 'open-uri'

class Presenter

  attr_reader :current_user

  def initialize(current_user)
    @current_user = current_user
  end

  def service
    GithubService.new(@current_user)
  end

  def followers
    service.followers.each do |follower|
      build_object(follower)
    end
  end

  def following
    service.following.each do |following|
      build_object(following)
    end
  end

  def starred
    service.starred.each do |starred|
      build_object(starred)
    end
  end

  def year_commits
    page = Nokogiri::HTML(open("https://github.com/#{@current_user.nickname}"))
    page.xpath("//*[@id='contributions-calendar']/div[3]/span[2]").text
  end

  def longest_streak
    page = Nokogiri::HTML(open("https://github.com/#{@current_user.nickname}"))
    page.xpath("//*[@id='contributions-calendar']/div[4]/span[2]").text
  end

  def current_streak
    page = Nokogiri::HTML(open("https://github.com/#{@current_user.nickname}"))
    page.xpath('//*[@id="contributions-calendar"]/div[5]/span[2]').text
  end

  def recent_commits
    events = []
    service.recent_commits(@current_user).each do |event|
      if (event[:type] == "PushEvent") && (event[:payload][:commits].first[:author][:name] == @current_user.nickname)
        events << build_object(event)
      end
    end
    events
  end

  def follower_commits
    service.follower_commits
  end

  private

  def build_object(data)
    OpenStruct.new(data)
  end

end