class AddTwitterToSpaces < ActiveRecord::Migration
  def change
    add_column :spaces, :twitter, :string
  end
end
