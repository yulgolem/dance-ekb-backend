class BasePresenter < Showcase::Presenter
  include Showcase::Traits::Record

  def publish_colored_id
    h.content_tag(
      :span,
      object.id,
      class: (object.published? ? "ui green label" : "ui red label"),
      data: {tooltip: (object.published? ? I18n.t("form.published") : I18n.t("form.unpublished"))}
    )
  end
end
