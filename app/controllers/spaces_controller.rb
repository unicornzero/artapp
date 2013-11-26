class SpacesController < ApplicationController
  before_action :authorize

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
    @space = Space.find(params[:id])
  end

  def edit
    @space = Space.find(params[:id])
    @photos = @space.photos
    @photo = @photos.new
  end

  def update
    @space = Space.find(params[:id])
    if @space.update_attributes(params.require(:space).permit(:name, :description))
      flash[:success] = 'Your changes have been saved.'
    else
      flash.now[:error] = 'Error- Your changes have not been saved'
    end
    redirect_to edit_space_path(@space)
  end

private
  def current_resource
    if params[:id]
      Space.find(params[:id])
    else
      Space.new
    end
  end
end