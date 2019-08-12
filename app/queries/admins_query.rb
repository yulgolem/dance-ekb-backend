class AdminsQuery < Admino::Query::Base
  ending_scope { order(:first_name, :last_name) }
end
