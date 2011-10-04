module Neo4j
  module Traversal
    class Traverser
      attr_accessor :from

      unless instance_methods.include? :original_each
        alias original_each each
      end

      def each(&block)
        if block
          original_each(&block)
        else
          to_enum
        end
      end
    end
  end
end
