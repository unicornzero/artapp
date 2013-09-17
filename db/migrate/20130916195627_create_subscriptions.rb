class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.references :user
      t.references :space
      t.string :stripe_customer_token
      t.string :plan
      t.boolean :active
      t.timestamps
    end
  end
end
