class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :mail
      t.string :name
      t.integer :grade_id
      t.string :password_digest
      t.timestamps null: false
    end
  end
end