require 'xml/libxml'

s = %{
  <root><a id="a"></a><b id="b"></b><c id="c"></c></root>
}

  parser = XML::Parser.new
  parser.string = s
  doc = parser.parse

  root = doc.root
  root.each { |node|
    node.content = "yep"
    node.remove! if node['id'] == "b"
  }

  puts doc
