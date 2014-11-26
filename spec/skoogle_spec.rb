require "date"
require "skoogledoc"
require "vcr"

VCR.configure do |c|
  c.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  c.hook_into :webmock
end

describe SkoogleDoc do
  KEY = "1YPYsTsedEQXJztXOtPcPkdiy16ow8P4c0DXzHKcaB7A"
  # I don’t want to authenticate over oauth every. single. time.
  config = {}
  VCR.use_cassette("authenticate") do
    config[:instance] = SkoogleDoc::Doc.new(KEY)
  end

  DOCUMENT_FIXTURE = File.join(__dir__, "fixtures", "body.html")

  it "can get a document" do
    VCR.use_cassette("latest_from_google") do
      latest = config[:instance].latest_from_google

      expect(latest.title).to eq "Skoogle Docs"
    end
  end

  it "can get a list of documents" do
    VCR.use_cassette("list_of_documents") do
      files = config[:instance].files

      expect(files.length).to eq 100
    end
  end

  describe "#transformations" do
    before(:each) do
      fixture = File.read(DOCUMENT_FIXTURE)
      @dom = Nokogiri::HTML(config[:instance].transform(fixture))
    end

    it "can add a css link" do
      expected_href = "./styleguide.css"

      # SkoogleDoc::Transformers.link(@dom, expected_href)

      href = @dom.at_css("link").attributes["href"].value
      expect(href).to eq expected_href
    end

    xit "can add a meta tag" do
      # SkoogleDoc::Transformers.meta(@dom, {content: "UTF-8"})

      # TODO: proper html5 support
      expect(@dom.at_css("meta").attributes["content"].value).to eq "UTF-8"
    end

    it "can create a generic cover page" do
      # SkoogleDoc::Transformers.cover_page(@dom)

      expect(@dom.at_css(".cover")).to be

      title = @dom.at_css(".cover__title .title").content
      expected_title = "Skoogle Docs"
      expect(title).to eq expected_title

      subtitle = @dom.at_css(".cover__title .subtitle").content
      expected_subtitle = "An un-arranged marriage between Google & Skookum"
      expect(subtitle).to eq expected_subtitle
    end

    xit "can create a custom cover page" do
      # SkoogleDoc::Transformers.cover_page(@dom, custom_cover_page)

      expect(@dom.at_css(".cover")).to be
    end

    it "can create a table of contents" do
      # SkoogleDoc::Transformers.toc(@dom, custom_cover_page)

      expect(@dom.at_css(".toc")).to be

      number_of_toc_anchors = @dom.search(".toc a").count
      number_of_headlines = @dom.search("main h1, main h2").count
      expect(number_of_toc_anchors).to eq number_of_headlines
    end

    xit "can create a custom table of contents" do
      # SkoogleDoc::Transformers.toc(@dom, custom_cover_page)

      expect(@dom.at_css(".toc")).to be
      number_of_toc_anchors = @dom.search(".toc a").count
      number_of_headlines = @dom.search("main h1, main h2").count
      expect(number_of_toc_anchors).to eq number_of_headlines
    end
  end

end
