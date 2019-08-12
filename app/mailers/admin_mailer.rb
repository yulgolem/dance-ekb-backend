class AdminMailer < ApplicationMailer
  layout "admin_mailer"
  helper ApplicationHelper

  def notification_message(email:, title:, body:, link:, fallback: nil, payload:)
    @title = title
    @body = body
    @link = link.presence
    @payload = payload&.with_indifferent_access
    mail(
      to: email,
      subject: @title
    )
  end
end
