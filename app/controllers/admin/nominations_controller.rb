class Admin::NominationsController < Admin::BaseController
  load_crud_resource

  def regenerate_schedule
    nomination = Nomination.find(params[:id])
    PerformanceSchedule::RegenerateFromNomination.execute(nomination: nomination)
    flash[:notice] = I18n.t('controllers.flash.done')
    redirect_to action: "index"
  end
end
