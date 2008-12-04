require 'rubygems'
require 'hpricot'

doc = Hpricot.parse( File.new('index.html') )

p doc.methods.sort




