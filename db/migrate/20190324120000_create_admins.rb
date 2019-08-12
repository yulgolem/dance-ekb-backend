class CreateAdmins < ActiveRecord::Migration[5.1]
  def change
    create_table(:admins) do |t|
      t.string :first_name
      t.string :last_name

      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.inet     :current_sign_in_ip
      t.inet     :last_sign_in_ip

      t.string :roles, default: [], array: true

      t.timestamps
    end

    add_index :admins, :email, unique: true
  end
end
