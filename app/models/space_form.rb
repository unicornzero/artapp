class SpaceForm

  def initialize(space)
    @space = space
  end

  def submit(params)
    params[:twitter] = TwitterHandle.build(params[:twitter]).sanitize
    space.update_attributes(params)
  end

  private

  attr_reader :space
end