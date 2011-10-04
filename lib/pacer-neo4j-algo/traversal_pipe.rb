module Pacer::Neo4j::Algo
  class TraversalPipe < Pacer::Pipes::RubyPipe
    def initialize(graph, block)
      super()
      @graph = graph
      @block = block
      reset
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
      @traverser = ::Neo4j::Traversal::Traverser.new(nil)
      @block.call(@traverser)
      @iterator = nil
    end

    private

    def prepare_traverser
      @traverser.from = @starts.next.getRawElement
      @iterator = @traverser.to_enum
    end
  end
end
