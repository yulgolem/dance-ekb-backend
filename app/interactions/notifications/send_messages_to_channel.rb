module Notifications
  class SendMessagesToChannel < BaseInteraction
    attr_accessor :channel, :channel_id, :message_kind, :fallback, :link, :id, :payload

    # def channel
    #   @channel ||= NotificationChannel.find(channel_id)
    # end

    def run
      # raise "Unexpected message kind #{message_kind}" if Notifications::NotificationRule::MESSAGE_KINDS[message_kind.to_sym].blank?
      # payload = self.payload&.with_indifferent_access || {}

      title = I18n.t(
        "#{message_kind}.title",
        scope: "messages.admin",
        id: id,
        # some_attr: payload[:some_attr]
      )

      body = I18n.t(
        "#{message_kind}.body",
        scope: "messages.admin"
      )

      send_messages(title, body)
    end

    def send_messages(title, body)
      channel.parsed_emails.each do |email|
        enqueue_email(email, title, body)
      end

      channel.parsed_slack_webhook_urls.each do |webhook_url|
        enqueue_slack_message(webhook_url, title, body)
      end
    end

    def enqueue_email(email, title, body)
      AdminMailer.notification_message(
        email: email,
        title: title,
        body: body,
        payload: payload,
        link: link,
        fallback: fallback
      ).deliver_later
    end

    def enqueue_slack_message(webhook_url, title, body)
      Notifications::SendMessageToSlack.execute_async(
        webhook_url: webhook_url,
        title: title,
        body: body,
        payload: payload,
        link: link,
        fallback: fallback
      )
    end
  end
end
