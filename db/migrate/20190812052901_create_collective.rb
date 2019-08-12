class CreateCollective < ActiveRecord::Migration[5.2]
  def change
    create_table :collectives do |t|
      t.string :city
      t.string :head_full_name
      t.string :title
      t.string :level
    end
  end
end
