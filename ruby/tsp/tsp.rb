module Tsp
  module Math
    extend self

    def dist(a, b)
      Integer.sqrt((a.x - b.x)**2 + (a.y - b.y)**2)
    end

    # Calculates route avaliation (sum of distances)
    def aval(route)
      return 0 if route.empty?
      route.zip(route[1, route.size]) # Combines node i with i+1
           .map { | zi | zip_dist(zi) }
           .sum
    end

    # Generates all node permutations
    def perms(nodes)
      nodes.permutation.lazy
    end

    private

      def zip_dist(zip_item)
        a, b = zip_item
        return 0 if b.nil?
        dist(a, b)
      end
  end
  
  class Node
    attr_reader :x, :y

    def initialize(x, y)
      @x, @y = x, y
    end

    def to_s
      "Node<x=#{x}, y=#{y}>"
    end
  end

  def self.solve(nodes)
    perms = Tsp::Math.perms(nodes)
    # Pack the route together with its avaliation
    best = perms.map{ | perm | [perm, Tsp::Math.aval(perm)] }
    best.min do | p1, p2 |
      p1.last <=> p2.last
    end
  end
end

nodes = [
  Tsp::Node.new(0, 0),
  Tsp::Node.new(5, 0),
  Tsp::Node.new(0, -5),
  Tsp::Node.new(10, 5),
  Tsp::Node.new(-10, 10),
  Tsp::Node.new(15, 10),
  Tsp::Node.new(-15, 20),
  Tsp::Node.new(25, -20),
  Tsp::Node.new(30, 0),
  Tsp::Node.new(42, 42),
]

route, aval =  Tsp::solve(nodes)
puts "Best route found:"
puts route.join(", ")
puts "Avaliation:\n#{aval}"
