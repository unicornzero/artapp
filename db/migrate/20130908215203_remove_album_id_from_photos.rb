class RemoveAlbumIdFromPhotos < ActiveRecord::Migration
  def change
    remove_column :photos, :album_id, :integer
  end
end
