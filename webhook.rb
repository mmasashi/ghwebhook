require 'sinatra'
require_relative './request_parser'
require_relative './slack_notifier'

SLACK_NAME=ENV['SLACK_NAME']
SLACK_TOKEN=ENV['SLACK_TOKEN']
SLACK_CHANNEL=ENV['SLACK_CHANNEL']
SLACK_USERNAME=ENV['SLACK_USERNAME'] || 'GitHub Wiki'

get '/' do
  "ok"
end

post '/' do
  event = RequestParser.new(request).parse
  if event
    puts "Sending slack message. event:#{request.env['HTTP_X_GITHUB_EVENT']}"
    SlackNotifier.new(SLACK_NAME, SLACK_TOKEN, SLACK_CHANNEL, SLACK_USERNAME).send_to_slack(event.build_message)
  else
    puts "Unsupported event. event:#{request.env['HTTP_X_GITHUB_EVENT']}"
  end
  "ok"
end

# for debug
def dump_request_param
  puts "# request.body"              # request body sent by the client (see below)
  puts request.body.read          # request body sent by the client (see below)
  puts "# request.scheme"            # "http"
  puts request.scheme            # "http"
  puts "# request.script_name"       # "/example"
  puts request.script_name       # "/example"
  puts "# request.path_info"         # "/foo"
  puts request.path_info         # "/foo"
  puts "# request.port"              # 80
  puts request.port              # 80
  puts "# request.request_method"    # "GET"
  puts request.request_method    # "GET"
  puts "# request.query_string"      # ""
  puts request.query_string      # ""
  puts "# request.content_length"    # length of request.body
  puts request.content_length    # length of request.body
  puts "# request.media_type"        # media type of request.body
  puts request.media_type        # media type of request.body
  puts "# request.host"              # "example.com"
  puts request.host              # "example.com"
  puts "# request.get?"              # true (similar methods for other verbs)
  puts request.get?              # true (similar methods for other verbs)
  puts "# request.form_data?"        # false
  puts request.form_data?        # false
  puts "# request.referer"           # the referer of the client or '/'
  puts request.referer           # the referer of the client or '/'
  puts "# request.user_agent"        # user agent (used by :agent condition)
  puts request.user_agent        # user agent (used by :agent condition)
  puts "# request.cookies"           # hash of browser cookies
  puts request.cookies           # hash of browser cookies
  puts "# request.xhr?"              # is this an ajax request?
  puts request.xhr?              # is this an ajax request?
  puts "# request.url"               # "http://example.com/example/foo"
  puts request.url               # "http://example.com/example/foo"
  puts "# request.path"              # "/example/foo"
  puts request.path              # "/example/foo"
  puts "# request.ip"                # client IP address
  puts request.ip                # client IP address
  puts "# request.secure?"           # false
  puts request.secure?           # false
  puts "# request.env"               # raw env hash handed in by Rack
  puts request.env               # raw env hash handed in by Rack
end
