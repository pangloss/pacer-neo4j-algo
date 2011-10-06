module Pacer::Neo4j::Algo
  module Algo
    module AlgoMixin

      # See http://neo4j.rubyforge.org/guides/algo.html and 
      # https://github.com/andreasronge/neo4j/blob/master/lib/neo4j/algo/algo.rb#L203
      # for info about the available algorithms.
      #
      # Currently available options:
      # * all_paths
      # * all_simple_paths
      # * shortest_paths
      # * dijkstra_paths
      # * a_star_paths
      # * with_length_paths
      #
      # Also available in singular versions that only return one path
      # per input vertex.
      def algo(name, args, &block)
        if Pacer.vertex? args
          chain_route transform: Algo, algo_name: name, to: args, block: block
        elsif args.is_a? Hash
          chain_route args.merge(transform: Algo, algo_name: name, block: block)
        else
          raise ArgumentError, "unknown args #{ args.inspect } for algo"
        end
      end
    end

    attr_accessor :algo_name, :from, :to, :block

    def attach_pipe(end_pipe)
      AlgoPipe.new(graph, algo_name, from, to, block).tap do |pipe|
        pipe.setStarts end_pipe if end_pipe
      end
    end
  end
end

module Pacer::Core::Graph::VerticesRoute
  include Pacer::Neo4j::Algo::Algo::AlgoMixin
end
