class UserMailer < ApplicationMailer
  layout "user_mailer"

  def new_registration(account_id)
    ErrorTracker.new(message: "No suitable entry found for offline form registration email") unless account_id
    @account = Account.find account_id
    address = Mail::Address.new @account.email
    address.display_name = @account.profile.first_name&.dup || ""
    @subject = "Приветствуем на платформе!"
    @preview_text = "Приветствуем на платформе!"
    mail(
      to: address.format,
      subject: @subject
    )
  end

  private

  def footer_info
    {
      address: "",
      contact_email: "",
      contact_phone: "",
      social: {
        facebook_url: "",
        instagram_url: "",
        vk_url: "",
        youtube_url: "",
        telegram_url: "",
      },
    }
  end
end
