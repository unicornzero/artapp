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
      redirect_to 'edit'
    end
  end

  def show
    @space = Space.where(id: params[:id]).first
  end

  def edit
    @space = Space.find(params[:id])
    @photos = @space.photos
    @photo = @photos.new
  end

  def update
    @space = Space.find(params[:id])
    #@photos = @space.photos
    #@photo = @photos.new
    if @space.update_attributes(params.require(:space).permit(:name))
      flash[:success] = 'Your changes have been saved.'
    else
      flash.now[:error] = 'Error- Your changes have not been saved'
      flash.now[:sother] = "params are #{params}"
    end
    redirect_to edit_space_path(@space)
  end

  def create_photo

  end


end