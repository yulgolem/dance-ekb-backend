class RenameFormatToPerformanceFormat < ActiveRecord::Migration[5.2]
  def change
    rename_table :formats, :performance_formats
    rename_column :nominations, :format_id, :performance_format_id
  end
end
