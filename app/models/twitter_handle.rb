class TwitterHandle

  def self.build(handle)
    if handle.present?
      new(handle)
    else
      NullTwitterHandle.new
    end
  end

  def initialize(handle)
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