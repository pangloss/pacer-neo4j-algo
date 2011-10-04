module Pacer::Neo4j::Algo
  class AlgoPipe < Pacer::Pipes::RubyPipe
    def initialize(graph, name, from, to, block)
      super()
      @graph = graph
      @name = name
      @from = from.getRawElement if from
      @to = to.getRawElement if to
      @block = block
      @iterator = nil
    end

    def processNextStart
      prepare_traverser unless @iterator
      begin
        @iterator.next.each_slice(2).flat_map do |vertex, edge|
          vertex = Pacer::Neo4jVertex.new(vertex, @graph)
          if edge
            [vertex, Pacer::Neo4jEdge.new(edge, @graph)]
          else
            vertex
          end
        end
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
      vertex = @starts.next.getRawElement
      traverser = Neo4j::Algo.send(@name, @from || vertex, @to || vertex)
      @block.call(traverser) if @block
      if traverser.single?
        @iterator = [traverser.to_a].to_enum
      else
        @iterator = traverser.to_enum
      end
    end
  end
end
