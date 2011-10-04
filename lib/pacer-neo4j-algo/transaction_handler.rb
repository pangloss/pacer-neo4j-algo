module Pacer::Neo4j::Algo
  # http://components.neo4j.org/neo4j/1.5.M01/apidocs/org/neo4j/graphdb/event/TransactionEventHandler.html
  # http://components.neo4j.org/neo4j/1.5.M01/apidocs/org/neo4j/graphdb/event/TransactionData.html
  class TransactionHandler
    include org.neo4j.graphdb.event.TransactionEventHandler

    def beforeCommit(data)
      $data = data
      puts data.class
    end

    def afterCommit(data, object)
      puts data.class
    end

    def afterRollback(data, object)
    end

    def print_data(data)
      ap [data.assignedNodeProperties, 
        data.assignedRelationshipProperties, 
        data.createdNodes, 
        data.createdRelationships, 
        data.deletedNodes, 
        data.deletedRelationships, 
        data.removedNodeProperties, 
        data.removedRelationshipProperties].map &:to_s
    end
  end
end
