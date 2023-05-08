class CreateUserQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :user_questions do |t|
      t.integer :user_id
      t.integer :question_id
      t.boolean :favorite
    end
  end
end
