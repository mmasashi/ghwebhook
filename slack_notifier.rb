require 'rest_client'

class SlackNotifier
  SLACK_WEB_HOOK_URL="https://%s.slack.com/services/hooks/incoming-webhook?token=%s"
  SLACK_TOKEN_KEY_NAME="token"

  def initialize(slackname, token, channel, username)
    @resource = RestClient::Resource.new(SLACK_WEB_HOOK_URL % [slackname, token])
    @channel = channel
    @username = username
  end

  def send_to_slack(text)
    req_param = {
      channel: @channel, username: @username, text: text
    }
    @resource.post(req_param.to_json)
  end
end

=begin
sn = SlackNotifier.new('flydata', '@masashi', 'Github Wiki')
text = wiki_change_message(
  "mmasashi", "https://github.com/mmasashi", "edit", "Home", "https://github.com/mmasashi/try_git/wiki/Home",
  "mmasashi/try_git", "https://github.com/mmasashi/try_git",
)
sn.send_to_slack(text)
#sn.send_to_slack('test-message')
=end
