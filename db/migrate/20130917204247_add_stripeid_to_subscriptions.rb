class AddStripeidToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :stripe_cust_id, :string
  end
end
