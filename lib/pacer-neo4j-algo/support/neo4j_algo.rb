module Neo4j
  class Algo
    def single?
      @single
    end

    def many?
      @many
    end

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
