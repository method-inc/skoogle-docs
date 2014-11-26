require "set"

def rand_n(n, max)
  randoms = Set.new
  loop do
    randoms << rand(max)
    return randoms.to_a if randoms.size >= n
  end
end

module SkoogleDoc
  module Transformers
    template = lambda { |n| File.join(__dir__, "templates", "#{n}.html") }

    DEFAULT_COVER_PAGE = File.read(template.call("coverpage"))
    DEFAULT_TOC = File.read(template.call("toc"))

    def self.wrap_content(dom)
      main = dom.create_element("main", class: "content")
      body = dom.at_css("body")
      main.children = body.children
      body.children = main
    end

    def self.cover_page(dom, html = DEFAULT_COVER_PAGE)
      body = dom.at_css("body")
      coverpage = Nokogiri::HTML(html)

      title = dom.at_css(".title")
      subtitle = dom.at_css(".subtitle")
      title.remove
      subtitle.remove

      coverpage.at_css(".cover__title .title").content = title.content

      # TODO: make sure this works for multiple subtitles like our contracts
      if subtitle
        new_subtitle = Transformers.node(
          "em",
          subtitle.content,
          class: "subtitle"
        )

        coverpage.at_css(".cover__title").add_child new_subtitle
      end

      body.prepend_child coverpage.to_html
    end

    def self.styled_lists(dom)
      lis = dom.search("li:last")
      lis.each do |li|
        if "#" == li.content[0]
          class_name = li.content.gsub("#", "").downcase
          li.parent.add_css_class class_name
          li.remove
        end
      end
    end

    def self.table_of_contents(dom)
      titles = dom.search(".content h1, .content h2")
      ns = rand_n(titles.count, titles.count * 5)

      toc = Nokogiri::HTML::DocumentFragment.parse '<ul class="toc" />'
      ul = toc.first_element_child

      titles.each_with_index do |t, i|
        id = t.name << ns[i].to_s
        t[:id] = id
        li = Nokogiri::XML::Node.new "li", toc
        a = Nokogiri::XML::Node.new "a", toc
        a[:href] = "##{id}"
        a.content = t.content

        li[:class] = t.name.downcase
        li.add_child a

        ul.add_child li
      end

      dom.at_css(:body).prepend_child toc.to_html
    end

    private

    def self.link(dom, href, rel = "stylesheet")
      head = dom.at_css("head") || dom.at_css("html")
      link = Nokogiri::HTML::Builder.new do |b|
        b.link(rel: rel, href: href)
      end.to_html
      head.prepend_child link
    end

    def self.meta(dom, o)
      head = dom.at_css("head") || dom.at_css("html")
      meta = Nokogiri::HTML::Builder.new do
        |b| b.meta(o)
      end.to_html
      head.prepend_child meta
    end

    def self.node(name, contents, attrs = {})
      Nokogiri::HTML::Builder.new do |b|
        b.send(name, attrs) { b.text contents }
      end.to_html
    end
  end
end
