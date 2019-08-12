class DatatablesPresenter < Admino::Table::Presenter
  def table_html_options
    {
      id: "datatables",
      class: "display cell-border hover striped order-column stripe nowrap",
      # style: 'width: 100%' # breaks column adjustment
    }
  end

  def tbody_tr_html_options(resource, _index)
    {
      data: {
        "item-id" => resource.id,
      },
    }
  end
end

# Datatables classes to set specific behaviour
#   cell-border - Cells with a border
#   compact - Increase the data density by reducing the cell padding
#   hover - Highlight a row when hovered over
#   order-column - Highlight the cells in the column currently being ordering upon
#   row-border - Rows with a border
#   stripe - Zebra striped rows
