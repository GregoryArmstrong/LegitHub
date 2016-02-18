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

  def recent_commits(user)
    events = []
    service.recent_commits(user.nickname).each do |event|
      if (event[:type] == "PushEvent") && (event[:payload][:commits].first[:author][:name] == user.nickname)
        events << build_object(event)
      end
    end
    events
  end

  def following_commits
    events = []
    service.following_commits.each do |person|
      counter = 0
      service.recent_commits(person).each do |event|
        if (event[:type] == "PushEvent") && (event[:actor][:login] == person )
          events << build_object(event)
          counter += 1
          if counter == 3
            counter = 0
            break
          end
        end
      end
    end
    events
  end

  def organizations(user)
    service.organizations(user).each do |org|
      build_object(org)
    end
  end

  def repositories(user)
    service.repositories(user).each do |repo|
      build_object(repo)
    end
  end

  private

  def build_object(data)
    OpenStruct.new(data)
  end

end
