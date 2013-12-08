class SpaceForm

  def initialize(space)
    @space = space
  end

  def submit(params)
    space.update_attributes(params)
  end

  private

  attr_reader :space
end