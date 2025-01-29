class CreateCompanies < ActiveRecord::Migration[8.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.datetime :discarded_at

      t.timestamps
    end
    add_index :companies, :discarded_at
  end
end
