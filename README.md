= Pacer::Neo4j::Algo

This project ties the two primary ways of using Neo4j in JRuby together.
It allows Neo4J's proprietary features to be used together with Pacer
and the Tinkerpop stack's graph agnostic features for maximum graphing
power!

== Examples

Here is a simple example that creates a Neo4J graph, adds 10 vertices,
strings them together in series with the edge label "label", then runs a
traversal for each element in the graph, returning the results grouped
by the originating vertex for each traversal. Phew! It's easier to code
than to describe!

```ruby
>> g = Pacer.neo4j '/tmp/neo'
#<Neo4jGraph>
>> 10.times { g.create_vertex }
10
>> g.v.each_cons(2) { |a, b| a.add_edges_to :label, b }
nil
>> g.e
#<E[0]:1-label-2>  #<E[1]:2-label-3>  #<E[2]:3-label-4>  #<E[3]:4-label-5>  #<E[4]:5-label-6>  #<E[5]:6-label-7>  #<E[6]:7-label-8>  #<E[7]:8-label-9> 
#<E[8]:9-label-10>
#Total: 9
#<GraphE>
>> p = g.v.group.values_route { |r| r.traversal { |t| t.outgoing(:label).depth(:all) } }
#<Group #<V[1]> values: [#<V[2]>, #<V[3]>, #<V[4]>, #<V[5]>, #<V[6]>, #<V[7]>, #<V[8]>, #<V[9]>, #<V[10]>] >
#<Group #<V[2]> values: [#<V[3]>, #<V[4]>, #<V[5]>, #<V[6]>, #<V[7]>, #<V[8]>, #<V[9]>, #<V[10]>] >
#<Group #<V[3]> values: [#<V[4]>, #<V[5]>, #<V[6]>, #<V[7]>, #<V[8]>, #<V[9]>, #<V[10]>] >
#<Group #<V[4]> values: [#<V[5]>, #<V[6]>, #<V[7]>, #<V[8]>, #<V[9]>, #<V[10]>] >
#<Group #<V[5]> values: [#<V[6]>, #<V[7]>, #<V[8]>, #<V[9]>, #<V[10]>] >
#<Group #<V[6]> values: [#<V[7]>, #<V[8]>, #<V[9]>, #<V[10]>] >
#<Group #<V[7]> values: [#<V[8]>, #<V[9]>, #<V[10]>] >
#<Group #<V[8]> values: [#<V[9]>, #<V[10]>] >
#<Group #<V[9]> values: [#<V[10]>] >
#<Group #<V[10]> values: [] >
#Total: 10
#<GraphV -> V-Group(#<V -> @>: {:values=>#<V -> V-Traversal>})>
```
