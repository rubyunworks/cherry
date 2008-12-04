# Subclass

class X
  def y ; "y"; end
end

class XC < X
  def x ; y ; end
end
  
# Module Include

module M
  def y ; "y" ; end
end

class MC
  include M
  def x ; y ; end
end

# Delegate

class D
  def y ; "y"; end
end

class DC
  def initialize ; @d = D.new ; end
  def x ; @d.y ; end
end


require 'benchmark'

$n = 1000000

xc = XC.new
mc = MC.new
dc = DC.new

Benchmark.bmbm do |x|
  x.report("delegate") { $n.times { dc.x } }
  x.report("subclass") { $n.times { xc.x } }
  x.report("include")  { $n.times { mc.x } }
end

