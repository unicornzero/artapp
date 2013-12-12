class NullTwitterHandle

  def new
    to_s
  end

  def format
    to_s
  end

  def sanitize
    to_s
  end

  def to_s
    I18n.t('twitter.handle_not_yet_set')
  end

end