class TwitterHandle

  def initialize(handle = 'twitter handle not yet added')
    @handle = handle
  end

  def format
    "@#{sanitize}"
  end

  def sanitize
    return if handle.nil?
    if handle.starts_with?("@")
      handle[1..-1]
    else
      handle
    end
  end

  private

  attr_reader :handle

end