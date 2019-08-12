class AdminController < ActionController::Base
  self.responder = AdminResponder

  protect_from_forgery with: :exception

  before_action :authenticate_admin!

  respond_to :html, :json

  # redirect rules based on ability
  rescue_from CanCan::AccessDenied do
    resources = [
      # OfflineForm,
      Admin,
      # Offline::FormalAssessment,
      # Offline::MeaningfulAssessment,
    ]

    resources.each do |resource|
      if can? :read, resource
        redirect_to url_for([:admin, resource])
      end
    end
  end

  def current_ability
    @current_ability ||= AdminAbility.new(admin: current_admin)
  end
end
