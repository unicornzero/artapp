class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.belongs_to :space
      t.string :name
      t.timestamps
    end
    create_table :photos do |t|
      t.belongs_to :album
      t.string :name
      t.timestamps
    end
  end
end
