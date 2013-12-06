class SpaceDecorator

	def initialize(space)
		@space = space
	end

	def twitter_handle
		@space.twitter || 

		if @space.twitter
			"@#{@space.twitter}"
		else
			"not yet set"
		end
	end

	private

	attr_reader :space
end