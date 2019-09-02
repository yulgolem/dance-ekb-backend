class StylesQuery < Admino::Query::Base
  ending_scope { order(:id) }
end
