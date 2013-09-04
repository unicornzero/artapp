class SpaceImportsController < ApplicationController

  before_action :authorize

  def new
    @space_import = SpaceImport.new
  end

  def create
    @space_import = SpaceImport.new(params.require(:space_import).permit(:file))
    if @space_import.save
      redirect_to spaces_path, notice: "Import Complete"
    else
      render :new
    end
  end

end