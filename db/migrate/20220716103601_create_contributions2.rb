class CreateContributions2 < ActiveRecord::Migration[6.1]
  def change
   add_column :contributions, :genre, :string
   add_column :contributions, :group, :string
   add_column :contributions, :birth, :string
    
  end
end
