class AddLevelsToNomination < ActiveRecord::Migration[5.2]
  def change
    add_column :nominations, :levels, :text, array: true, default: []
  end
end
