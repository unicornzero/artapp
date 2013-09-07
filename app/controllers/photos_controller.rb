class PhotosController < ApplicationController

  def create
    if photo = Photo.create(params.require(:photo).permit(:album_id, :name, :image))
      flash[:success] = 'Your image has been uploaded'
      redirect_to edit_space_path(photo.album.space)
    else
      flash[:error] = 'Error- Your changes have not been saved'
      redirect_to spaces_path
    end
  end

end