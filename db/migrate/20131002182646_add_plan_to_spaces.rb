class AddPlanToSpaces < ActiveRecord::Migration
  def change
    add_column :spaces, :plan, :string
  end
end
