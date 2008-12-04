require 'rubygems'
require 'hpricot'

puts
puts '*******************************'
puts '*  Demo of Hpricot      /\    *'
puts '*                     ( )( )  *'
puts '*******************************'
puts
puts s = "html = Hpricot.parse( File.read('demo.xml') )"
puts "=> #{eval s}"
puts
#puts s = "html['title']"
#puts "=> #{eval s}"
puts
puts s = "html/:section"
puts "=> #{eval s}"
puts
puts s = "html/:section/:item"
puts "=> #{eval s}"
puts

