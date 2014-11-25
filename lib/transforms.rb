module SkoogleDoc
  module Transformers
    template = lambda {|n| File.join(__dir__, "templates", "#{n}.html") }

    DEFAULT_COVER_PAGE = File.read(template.call('coverpage'))
    DEFAULT_TOC = File.read(template.call('toc'))

    def Transformers.link(href, rel='stylesheet')
      Nokogiri::HTML::Builder.new{|dom| dom.link(rel: rel, href: href) }.to_html
    end

    def Transformers.meta(o)
      Nokogiri::HTML::Builder.new{|dom| dom.meta(o) }.to_html
    end

    def Transformers.cover_page(html, contents)
      Nokogiri::HTML::Builder.new do |dom|
      end
    end
  end
end
