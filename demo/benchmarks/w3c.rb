require 'rexml/document'
require 'xml/libxml'
#require 'cherry/xml'
require 'open-uri'
require 'benchmark'

site = "http://www.w3.org/"
str = open(site).read
n = 10

puts "Parse #{site} #{n} times:"
Benchmark.bm(20) do |x|
  #x.report("cherry (libxml)") {
  #  n.times { Cherry::Xml.new( str, :libxml ) }
  #}
  #x.report("cherry (rexml)") {
  #  n.times { Cherry::Xml.new( str, :rexml ) }
  #}
  x.report("ruby-libxml") {
    n.times {
      prs = ::XML::Parser.new
      prs.string = str
      prs.parse.root
    }
  }
  x.report("rexml") {
    n.times {
      ::REXML::Document.new( str )
    }
  }
end
