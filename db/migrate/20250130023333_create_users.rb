class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false, index: { unique: true }
      t.references :company, null: false, foreign_key: true
      t.datetime :discarded_at, index: true

      t.timestamps
    end
  end
end
