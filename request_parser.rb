require 'json'

class RequestParser
  def initialize(request)
    @request = request
  end

  attr_accessor :request

  def parse
    case request.env['HTTP_X_GITHUB_EVENT']
    when 'gollum'
      parse_gollum
    else
      nil
    end
  end

  def parse_gollum
    j = JSON.parse(request.body.read)
    GollumEvent.new(
      j['sender']['login'], j['sender']['html_url'], j['pages'][0]['action'],
      j['pages'][0]['page_name'], j['pages'][0]['html_url'],
      j['repository']['full_name'], j['repository']['html_url'],
    )
  end
end

class Event
  def build_message
    nil
  end
end

#  def self.wiki_change_message(sender_name, sender_link, action, page_name, page_link, repo_name, repo_url)
class GollumEvent < Event
  def initialize(sender_name, sender_link, action, page_name, page_link, repo_name, repo_url)
    @sender_name = sender_name
    @sender_link = sender_link
    @action = action
    @page_name = page_name
    @page_link = page_link
    @repo_name = repo_name
    @repo_url = repo_url
  end

  attr_accessor :sender_name, :sender_link, :action, :page_name, :page_link, :repo_name, :repo_url

  def build_message
    <<EOT
[#{repo_name}] <#{sender_link}|#{sender_name}> #{action} the <#{page_link}|#{page_name}> wiki of <#{repo_url}|#{repo_name}>
EOT
  end

=begin
  def wiki_change_message(sender_name, sender_link, action, page_name, page_link, repo_name, repo_url)
    <<EOT
[#{repo_name}] <#{sender_link}|#{sender_name}> #{action} the <#{page_link}|#{page_name}> wiki of <#{repo_url}|#{repo_name}>
EOT
  end
=end
end
