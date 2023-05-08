class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.string :body
      t.string :image
      t.datetime :created_at
      t.datetime :updated_at
      t.integer :user_id
      t.integer :subject_id
    end
  end
end
