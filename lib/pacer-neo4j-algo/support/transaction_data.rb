module Pacer::Neo4j::Algo
  TransactionalData = org.neo4j.kernel.impl.core.TransactionDataImpl
  class TransactionalData
    def properties
      assignedNodeProperties 
    end

    def edge_properties
      assignedRelationshipProperties 
    end

    def vertices(graph)
      createdNodes.map { |v| Pacer::Neo4jVertex.new(v, graph) }
    end

    def edges(graph)
      createdRelationships.map { |e| Pacer::Neo4jEdge.new(e, graph) }
    end

    def deleted_vertices(graph)
      deletedNodes.map { |v| Pacer::Neo4jVertex.new(v, graph) }
    end

    def deleted_edges(graph)
      deletedRelationships.map { |e| Pacer::Neo4jEdge.new(e, graph) }
    end

    def deleted_properties
      removedNodeProperties 
    end

    def deleted_edge_properties
      removedRelationshipProperties
    end
  end
end
