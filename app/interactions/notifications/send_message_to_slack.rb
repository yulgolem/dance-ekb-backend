module Notifications
  class SendMessageToSlack < BaseInteraction
    attr_accessor :webhook_url, :title, :body, :link, :payload, :fallback

    def run
      payload = self.payload&.with_indifferent_access
      options = {
        text: title,
        icon_emoji: ":bell:",
        # channel: OVERRIDEME,
        unfurl_media: false,
        attachments: [
          {
            author_name: payload[:full_name],
            fallback: body,
            text: body,
            color: "good",
          },
        ],
      }
      attachment = options[:attachments].first

      if link.present?
        attachment[:actions] ||= []
        attachment[:actions] << {
          type: "button",
          text: I18n.t("messages.buttons.open_in_admin_ui"),
          url: "https://#{Settings.urls.admin}#{link}",
          # style: "primary"
        }
      end

      if payload[:email].present?
        attachment[:fields] ||= []
        attachment[:fields] <<
          {
            title: "Email",
            value: payload[:email],
            short: true,
          }
      end

      if payload[:phone].present?
        attachment[:fields] ||= []
        attachment[:fields] <<
          {
            title: "Phone",
            value: Phonelib.parse(payload[:phone]).e164,
            short: true,
          }
      end

      if payload[:city].present?
        attachment[:fields] ||= []
        attachment[:fields] <<
          {
            title: "City",
            value: payload[:city],
            short: true,
          }
      end

      if fallback
        attachment[:fields] ||= []
        attachment[:fields] <<
          {
            title: "Fallback",
            value: ":warning:",
            short: true,
          }
      end

      # puts options.to_json
      slack_notifier = Slack::Notifier.new webhook_url, username: "imi_site"
      slack_notifier.ping(options)
    end
  end
end
