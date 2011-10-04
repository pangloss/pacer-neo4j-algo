module Pacer::Neo4j::Algo
  PropertyEntry = org.neo4j.kernel.impl.core.PropertyEntryImpl
  NodeProxy = org.neo4j.kernel.impl.core.NodeProxy
  RelationshipProxy = org.neo4j.kernel.impl.core.RelationshipProxy

  class PropertyEntry
    def vertex(graph)
      if entity.is_a? NodeProxy
        v = Pacer::Neo4jVertex.new(entity, graph)
        v.graph = graph
        v
      else
        nil
      end
    end

    def edge(graph)
      if entity.is_a? RelationshipProxy
        e = Pacer::Neo4jEdge.new(entity, graph)
        e.graph = graph
        e
      else
        nil
      end
    end
  end
end
