class CreateNominationStyle < ActiveRecord::Migration[5.2]
  def change
    create_table :nomination_styles do |t|
      t.references :nomination, index: true, foreign_key: true
      t.references :style, index: true, foreign_key: true
      t.integer :priority
    end

    remove_column :nominations, :style_id, :integer
  end
end
