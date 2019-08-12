class Admin::AdminsController < Admin::BaseController
  load_crud_resource

  prepend_before_action :remove_blank_password_fields, only: :update

  protected

  def remove_blank_password_fields
    return unless params[:admin] && params[:admin][:password].blank?
    params[:admin].delete(:password)
    params[:admin].delete(:password_confirmation)
  end
end
