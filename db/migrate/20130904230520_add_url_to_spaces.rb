class AddUrlToSpaces < ActiveRecord::Migration
  def change
    add_column :spaces, :url, :string
  end
end
