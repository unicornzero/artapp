class UrlLink

  def self.build(url = nil)
    if url.present?
      new(url)
    else
      NullUrlLink.new
    end
  end

  def initialize(url)
    @url = url
  end

  def pretty_url
    remove_http
  end

  def full_url
    remove_trailing_slash(url)
  end

  private

  attr_reader :url, :tempurl

  def remove_http
    if url.starts_with? "http://www."
      @tempurl = url[7..-1]
      remove_trailing_slash(@tempurl)
    else
      remove_trailing_slash(url)
    end
  end

  def remove_trailing_slash(tempurl)
    if tempurl.ends_with? "/"
      tempurl[0..-2]
    else
      tempurl
    end
  end
end