module Pacer::Neo4j::Algo
  module Traversal
    module RouteMixin
      def traversal(traverser = nil, &block)
        if traverser
          chain_route transform: Traversal, traverser: traverser
        else
          chain_route transform: Traversal, block: block
        end
      end
    end

    attr_accessor :traverser

    def after_initialize
      raise ArgumentError, 'traversal initialized without a traverser' unless @traverser
    end

    def block=(block)
      @traverser = ::Neo4j::Traversal::Traverser.new(nil)
      block.call(@traverser)
    end

    def attach_pipe(end_pipe)
      TraversalPipe.new(graph, traverser).tap do |pipe|
        pipe.setStarts end_pipe if end_pipe
      end
    end
  end
end

module Pacer::Core::Graph::VerticesRoute
  include Pacer::Neo4j::Algo::Traversal::RouteMixin
end

