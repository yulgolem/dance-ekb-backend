class HomeController < AdminController
  # what the heck going on here?
  def index
    resources = [
      # OfflineForm,
      Admin,
      # Offline::FormalAssessment,
      # Offline::MeaningfulAssessment,
    ]

    resources.each do |resource|
      return redirect_to url_for([:admin, resource]) if can? :read, resource
    end

    authorize! :read, Admin
  end
end
