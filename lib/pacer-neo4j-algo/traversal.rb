module Pacer::Neo4j::Algo
  module Traversal
    module RouteMixin
      def traversal(&block)
        chain_route transform: Traversal, block: block
      end
    end

    attr_reader :traverser

    def after_initialize
      raise ArgumentError, 'traversal route must have a block' unless @block
    end

    def block=(block)
      @block = block
    end

    def attach_pipe(end_pipe)
      TraversalPipe.new(graph, @block).tap do |pipe|
        pipe.setStarts end_pipe if end_pipe
      end
    end
  end
end

module Pacer::Core::Graph::VerticesRoute
  include Pacer::Neo4j::Algo::Traversal::RouteMixin
end

