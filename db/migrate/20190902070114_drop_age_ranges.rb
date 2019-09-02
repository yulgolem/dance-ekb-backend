class DropAgeRanges < ActiveRecord::Migration[5.2]
  def change
    reversible do |dir|
      dir.up do
        remove_column :nominations, :age_range_id
        drop_table :age_ranges
      end

      dir.down do

      end
    end
  end
end
