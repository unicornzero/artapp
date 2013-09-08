class PhotosController < ApplicationController

  def create
    @photo = Photo.create(params.require(:photo).permit(:album_id, :name, :image))
    if @photo.valid?
      flash[:success] = 'Your image has been uploaded'
      redirect_to edit_space_path(@photo.album.space)
    elsif (space = Album.where(id: params[:photo][:album_id]).first.space)
      flash[:error] = 'Error- Your image has not been saved'
      unless !params[:name].to_s.empty?
        flash[:image_name_error] = 'Image Name cannot be blank.'
      end
      unless !@photo.image.to_s.empty?
        flash[:image_file_error] = 'File cannot be empty.'
      end      
      redirect_to edit_space_path(space)
    else
      redirect_to spaces_path
    end
  end

  def edit
    @photo = Photo.find(params[:id])
  end

  def update
    photo = Photo.find(params[:id])
    photo.update_attributes(params.require(:photo).permit(:name))
    if photo.valid?
      photo.save
      flash[:success] = 'Your image has been updated'
      redirect_to space_path(photo.album.space)
    else
      flash[:error] = 'Your change has not been saved'
      render 'edit'
    end
  end

  def destroy
    photo = Photo.find(params[:id])
    space = photo.album.space
    photo.destroy
    flash[:success] = "Your image has been deleted"
    redirect_to edit_space_path(space)
  end

end