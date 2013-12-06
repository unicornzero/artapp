class NullTwitterHandle
	def to_s
		I18n.t('twitter.handle_not_yet_set')
	end
end