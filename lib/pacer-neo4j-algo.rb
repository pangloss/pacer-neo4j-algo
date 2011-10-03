require "pacer-neo4j-algo/version"
require 'neo4j'
require 'pacer-neo4j'

module Pacer
  module Neo4j
    module Algo
      # Returns the time pacer-zmq was last reloaded (or when it was started).
      class << self
        def reload_time
          if defined? @reload_time
            @reload_time
          else
            START_TIME
          end
        end

        # Reload all Ruby modified files in the pacer-zmq library. Useful for debugging
        # in the console. Does not do any of the fancy stuff that Rails reloading
        # does.  Certain types of changes will still require restarting the
        # session.
        def reload!
          require 'pathname'
          Pathname.new(File.expand_path(__FILE__)).parent.find do |path|
            if path.extname == '.rb' and path.mtime > reload_time
              puts path.to_s
              load path.to_s
            end
          end
          @reload_time = Time.now
        end

      end
    end
  end
end

require 'pacer-neo4j-algo/support/neo4j_traverser'
require 'pacer-neo4j-algo/traversal'
require 'pacer-neo4j-algo/traversal_pipe'
