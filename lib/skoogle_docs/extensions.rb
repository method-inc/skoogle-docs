require "google_drive"
require "nokogiri"

GoogleDrive::File.class_eval do

  # Get the HTML body of the file
  #
  # @return [String]
  def body
    unless @body
      string = download_to_string(content_type: "text/html")
      @body = Nokogiri::HTML(string).css("body").to_s
    end
    @body
  end

  # Get the date and time of last update
  #
  # @return [DateTime]
  def updated_at
    unless @updated_at
      updated_at = document_feed_entry.search("updated").first.text
      @updated_at = DateTime.parse(updated_at)
    end
    @updated_at
  end
end

GoogleDrive::Session.class_eval do
  # i would expect this to bring DOCS_BASE_URL into scope
  include GoogleDrive::Util
  DOCS_BASE_URL = "https://docs.google.com/feeds/default/private/full"

  # Returns GoogleDrive::File or its subclass whose key exactly matches +key+.
  # Raises an error if not found.
  #
  # e.g.
  # session.file_by_key("0AkCUOtrZrtc-dHhPSDNDVFpTWEhqNW8yaVVTNlZrLVE")
  def file_by_key(key)
    url = "#{DOCS_BASE_URL}/#{key}?v=3"
    begin
      doc = request(:get, url, auth: :writely)
      return entry_element_to_file(doc.css("entry"))
    rescue GoogleDrive::Error => _
      raise(ArgumentError, "Invalid key: %p" % key)
    end
  end
end

class Nokogiri::XML::Node
  def add_css_class(*classes)
    existing = (self["class"] || "").split(/\s+/)
    self["class"] = existing.concat(classes).uniq.join(" ")
  end
end
