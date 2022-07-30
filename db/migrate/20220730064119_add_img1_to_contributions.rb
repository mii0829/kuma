class AddImg1ToContributions < ActiveRecord::Migration[6.1]
  def change
    add_column :contributions, :img1, :string
  end
end
