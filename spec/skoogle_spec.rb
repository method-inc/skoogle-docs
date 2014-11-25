require 'date'
require 'skoogledoc'
require 'pry'

describe SkoogleDoc do
  KEY = '1YPYsTsedEQXJztXOtPcPkdiy16ow8P4c0DXzHKcaB7A'
  # I don’t want to authenticate over oauth every. single. time.
  instance = SkoogleDoc::Doc.new(KEY)

  DOCUMENT_FIXTURE = File.join(__dir__, "fixtures", "body.html")

  it 'can get a document' do
    latest = instance.latest_from_google
    latest.download_to_file DOCUMENT_FIXTURE
    
    expect(latest.title).to eq("Skoogle Docs")
  end

  it 'can get a list of documents' do
    files = instance.files
    
    expect(files.length).to eq(100)
  end

  it 'can transform' do
    dom = Nokogiri::HTML(instance.transform(File.read(DOCUMENT_FIXTURE)))
    expect(dom.at_css('link').attributes["href"].value).to eq("./styleguide.css")
    
    expect(true).to eq(true)
  end

end

