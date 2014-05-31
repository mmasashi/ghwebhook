Github Wiki Webhook for Slack
========

This project is a github webhook service which sends github wiki change message to Slack. The motivation is that Slack does not support to notify wiki changes. You can host this service on Heroku and get notifications for free.

## How to setup

- Clone this project to your local
- Initialize as a Heroku project
  - `heroku init`
- Edit `setup_config.sh` and run it
  - SLACK_NAME: slack sub domain name for your organization
  - SLACK_TOKEN: Slack API token
  - SLACK_CHANNEL: Slack channel to send the message
  - SLACK_USERNAME: Sender name shown in the message
- Deploy
  - `git push heroku master`
- Register your webhook to your github project.
  - Your Project Page -> [Settings] -> [Webhooks & Services]
  - Click [Add webhook]
  - Put "Payload URL"
  - "Secret" is optional
  - Select "Let me select individual events."
  - Select "Gollum" only
  - Click "Add webhook"


## License

MIT License
