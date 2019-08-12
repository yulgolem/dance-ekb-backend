# Preview all emails at http://localhost:3000/rails/mailers
class UserMailerPreview < ActionMailer::Preview
  def new_registration
    UserMailer.new_registration Account.last&.id
  end

  def offline_form_submit
    UserMailer.offline_form_submit OfflineForm.submitted.last&.id
  end
end
