class NullTwitterHandle
  
  def method_missing(*args)
    I18n.t('twitter.handle_not_yet_set')
  end

end