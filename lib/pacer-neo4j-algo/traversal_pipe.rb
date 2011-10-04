module Pacer::Neo4j::Algo
  class TraversalPipe < Pacer::Pipes::RubyPipe
    def initialize(graph, traverser)
      super()
      @graph = graph
      @traverser = traverser
      @iterator = nil
    end

    def processNextStart
      prepare_traverser unless @iterator
      begin
        vertex = @iterator.next
        Pacer::Neo4jVertex.new(vertex, @graph)
      rescue StopIteration
        prepare_traverser
        retry
      end
    end

    def reset
      @iterator = nil
      super
    end

    private

    def prepare_traverser
      @traverser.from = @starts.next.getRawElement
      @iterator = @traverser.to_enum
    end
  end
end
