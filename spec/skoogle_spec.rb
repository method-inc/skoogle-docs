require 'date'
require 'skoogledoc'
require 'vcr'
require 'pry'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock
end

describe SkoogleDoc do
  KEY = '1YPYsTsedEQXJztXOtPcPkdiy16ow8P4c0DXzHKcaB7A'
  # I don’t want to authenticate over oauth every. single. time.
  config = {}
  VCR.use_cassette('authenticate') do
    config[:instance] = SkoogleDoc::Doc.new(KEY)
  end

  DOCUMENT_FIXTURE = File.join(__dir__, "fixtures", "body.html")

  it 'can get a document' do
    VCR.use_cassette('latest_from_google') do
      latest = config[:instance].latest_from_google

      expect(latest.title).to eq("Skoogle Docs")
    end
  end

  it 'can get a list of documents' do
    VCR.use_cassette('list_of_documents') do
      files = config[:instance].files

      expect(files.length).to eq(100)
    end
  end

  describe '#transformations' do
    it 'can add a css link' do
      dom = Nokogiri::HTML(config[:instance].transform(File.read(DOCUMENT_FIXTURE)))
      #SkoogleDoc::Transformers.link('./styleguide.css')

      expect(dom.at_css("link").attributes["href"].value).to eq("./styleguide.css")
    end

    xit 'can add a meta tag' do
      dom = Nokogiri::HTML(config[:instance].transform(File.read(DOCUMENT_FIXTURE)))
      #SkoogleDoc::Transformers.meta(dom, {content: 'UTF-8'})

      # TODO: proper html5 support
      expect(dom.at_css("meta").attributes["content"].value).to eq("UTF-8")
    end

    it 'can create a generic cover page' do
      dom = Nokogiri::HTML(config[:instance].transform(File.read(DOCUMENT_FIXTURE)))
      #SkoogleDoc::Transformers.cover_page(dom)

      expect(dom.at_css(".cover")).to be
      expect(dom.at_css(".cover__title .title").content).to eq "Skoogle Docs"
      expect(dom.at_css(".cover__title .subtitle").content).to eq "An un-arranged marriage between Google & Skookum"
    end

    xit 'can create a custom cover page' do
      dom = Nokogiri::HTML(config[:instance].transform(File.read(DOCUMENT_FIXTURE)))
      #SkoogleDoc::Transformers.cover_page(dom, custom_cover_page)

      expect(dom.at_css(".cover")).to be
    end

    it 'can create a table of contents' do
      dom = Nokogiri::HTML(config[:instance].transform(File.read(DOCUMENT_FIXTURE)))
      #SkoogleDoc::Transformers.toc(dom, custom_cover_page)

      expect(dom.at_css(".toc")).to be
      expect(dom.search(".toc a").count).to eq dom.search('main h1, main h2').count
    end

    xit 'can create a custom table of contents' do
      dom = Nokogiri::HTML(config[:instance].transform(File.read(DOCUMENT_FIXTURE)))
      #SkoogleDoc::Transformers.toc(dom, custom_cover_page)

      expect(dom.at_css(".toc")).to be
      expect(dom.search(".toc a").count).to eq dom.search('main h1, main h2').count
    end
  end

end

