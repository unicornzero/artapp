class PhotosController < ApplicationController

  def new
    @space = Space.where(id: params[:space_id]).first
    @photo = @space.photos.build
    @photo.space_id = params[:space_id]
  end

  def create
    @space = Space.where(id: params[:space_id]).first
    @photo = @space.photos.build
    @photo.update_attributes(params.require(:photo).permit(:space_id, :name, :image))
    if @photo.save
      flash[:success] = 'Your image has been uploaded'
      redirect_to edit_space_path(@photo.space)
    else
      flash[:error] = 'Error- Your image has not been saved'
      unless !params[:name].to_s.empty?
        flash[:image_name_error] = 'Image Name cannot be blank.'
      end
      unless !@photo.image.to_s.empty?
        flash[:image_file_error] = 'File cannot be empty.'
      end
      @photo.space_id = params[:photo][:space_id]

      render 'new'
    end
  end

  def edit
    @photo = Photo.where(id: params[:id]).first
    @space = @photo.space
  end

  def update
    photo = Photo.find(params[:id])
    photo.update_attributes(params.require(:photo).permit(:name))
    if photo.valid?
      photo.save
      flash[:success] = 'Your image has been updated'
      redirect_to space_path(photo.space)
    else
      flash[:error] = 'Your change has not been saved'
      render 'edit'
    end
  end

  def destroy
    photo = Photo.find(params[:id])
    space = photo.space
    photo.destroy
    flash[:success] = "Your image has been deleted"
    redirect_to edit_space_path(space)
  end

end