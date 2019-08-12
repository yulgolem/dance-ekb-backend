class ApplicationMailer < ActionMailer::Base
  default from: "\"IMI\" <#{Settings.email.from}>"
  default 'Message-ID': ->(_v) { "<#{SecureRandom.uuid}@#{ActionMailer::Base.smtp_settings[:domain]}>" }
end
