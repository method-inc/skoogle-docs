module SkoogleDocs
  # SkoogleDocs Transformer object executes the transformations
  #
  # @api public
  class Transformer
    # Instantiates a new SkoogleDocs::Transformer object
    #
    # @param source [String] the document content that needs to be transformed
    #
    # @return [SkoogleDocs::Transformer]
    #
    # @example Passing a String
    #   transformer = SkoogleDocs::Transformer.new(source)
    def initialize(source)
      @dom = Nokogiri::HTML(source)
    end

    # Executes all bots on the source - (auto)bots roll out!
    #
    # @return [String]
    #
    # @example Rolling Out
    #   transformer = SkoogleDocs::Transformer.new(source)
    #   doc = transformer.rollout
    def rollout
      bots = filter_bots(Bots::Bot.all)
      bots.each { |b| b.transform(@dom) }

      @dom.to_s
    end

    private

    # TODO: Filter which bots to run using configuration files/options
    def filter_bots(bots)
      bots
    end
  end
end
