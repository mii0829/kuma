class CrateGrades < ActiveRecord::Migration[6.1]
  def change
    create_table :grades do |t|
      t.string :name
    end
  end
end
