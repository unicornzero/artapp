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
    wwwify
  end

  def full_url
    url
  end

  private

  attr_reader :url, :tempurl

  def wwwify
    if url.starts_with? "http://www."
      @tempurl = url[7..-1]
      endify(@tempurl)
    else
      endify(url)
    end
  end

  def endify(tempurl)
    if tempurl.ends_with? "/"
      tempurl[0..-2]
    else
      tempurl
    end
  end
end