class TwitterHandle

	def self.build(handle)
		if handle.present?
			new(handle)
		else
			NullTwitterHandle.new
		end
	end

	def constructor(handle)
		@handle = handle
	end

	def to_s
		"@#{handle}"
	end

	private

	attr_reader :handle
end