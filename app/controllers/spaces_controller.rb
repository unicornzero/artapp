class SpacesController < ApplicationController
  before_action :authorize, only: [:new, :create, :edit, :update]

  def index
    @spaces = Space.all
  end

  def new
    @space = Space.new
  end

  def create
    @space = Space.new(params.require(:space).permit(:name))
    if @space.save
      flash[:success] = 'Your Space has been created.'
      redirect_to @space
    else
      flash[:error] = 'Error- Your changes have not been saved'
      render 'new'
    end
  end

  def show
    @space = Space.find(params[:id])
  end

  def edit
    @space = Space.find(params[:id])
    @album = @space.albums.first
    @new_photo = @album.photos.build
    @photos = @album.photos
  end

  def update
    @space = Space.find(params[:id])
    if @space.update_attributes(params.require(:space).permit(:name))
      flash[:success] = 'Your changes have been saved.'
      redirect_to @space
    else
      flash[:error] = 'Error- Your changes have not been saved'
      render 'edit'
    end
  end

private


end