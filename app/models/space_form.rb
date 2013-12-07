class SpaceForm

	def initialize(space)
	  @space = space
	end

	def submit(params)
	  params[:twitter] = sanitize_twitter_handle(params[:twitter])
	  space.update_attributes(params)
	end

	private

	def sanitize_twitter_handle(handle)
	  return if handle.empty?
	  handle[1..-1] if handle.starts_with?("@")
	end

	attr_reader :space
end