class AdminTablePresenter < Admino::Table::Presenter
  def table_html_options
    html_options = {
      data: {
        "items-type" => collection_klass.model_name.param_key,
      },
      class: "ui selectable celled compact table table-admino",
    }
    # if collection_klass.respond_to?(:rankers) && collection_klass.rankers.present?
    #   html_options[:class] += ' table-sortable'
    #   html_options[:data]['items-position-field'] = "#{collection_klass.rankers.first.name}_position"
    # end
    html_options[:class] += " sortable"
    html_options
  end

  def tbody_tr_html_options(resource, _index)
    {
      data: {
        "item-id" => resource.id,
      },
    }
  end
end
