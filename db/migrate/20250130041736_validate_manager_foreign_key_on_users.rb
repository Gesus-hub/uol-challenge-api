class ValidateManagerForeignKeyOnUsers < ActiveRecord::Migration[8.0]
  def change
    validate_foreign_key :users, :users
  end
end
