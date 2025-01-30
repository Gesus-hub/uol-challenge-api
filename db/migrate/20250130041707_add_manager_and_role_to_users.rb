class AddManagerAndRoleToUsers < ActiveRecord::Migration[8.0]
  disable_ddl_transaction!

  def change
    add_column :users, :manager_id, :integer
    add_index :users, :manager_id, algorithm: :concurrently
    add_foreign_key :users, :users, column: :manager_id, validate: false

    add_column :users, :role, :integer, default: 0, null: false
  end
end
