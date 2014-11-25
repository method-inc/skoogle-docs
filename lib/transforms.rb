module SkoogleDoc
  module Transformers
    template = lambda {|n| File.join(__dir__, "templates", "#{n}.html") }

    DEFAULT_COVER_PAGE = File.read(template.call('coverpage'))
    DEFAULT_TOC = File.read(template.call('toc'))

    def Transformers.wrap_content(dom)
      main = dom.create_element('main', class: 'content')
      body = dom.at_css('body')
      main.children = body.children
      body.children = main
    end

    def Transformers.cover_page(dom, html=DEFAULT_COVER_PAGE)
      body = dom.at_css('body')
      coverpage = Nokogiri::HTML(html)

      title = dom.at_css('.title')
      subtitle = dom.at_css('.subtitle')
      title.remove
      subtitle.remove

      coverpage.at_css('.cover__title .title').content = title.content

      # TODO: make sure this works for multiple subtitles like our contracts
      if subtitle
        new_subtitle = Transformers.node('em', subtitle.content, {class: 'subtitle'})
        coverpage.at_css('.cover__title').add_child new_subtitle
      end

      body.prepend_child coverpage.to_html
    end

    def Transformers.styled_lists(dom)
      lis = dom.search('li:last')
      lis.each do |li|
        if "#" == li.content[0]
          className = li.content.gsub('#', '').downcase
          li.parent.add_css_class className
          li.remove
        end
      end
    end

    private

    def Transformers.link(dom, href, rel='stylesheet')
      head = dom.at_css('head') || dom.at_css('html')
      link = Nokogiri::HTML::Builder.new{|b| b.link(rel: rel, href: href) }.to_html
      head.prepend_child link
    end

    def Transformers.meta(dom, o)
      head = dom.at_css('head') || dom.at_css('html')
      meta = Nokogiri::HTML::Builder.new{|b| b.meta(o) }.to_html
      head.prepend_child meta
    end

    def Transformers.node(name, contents, attrs={})
      Nokogiri::HTML::Builder.new do |b|
        b.send(name, attrs) {
          b.text contents
        }
      end.to_html
    end

  end

end

