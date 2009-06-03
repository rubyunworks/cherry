require 'cherry/xml'

XDOC = %{
<root>
  <top>
    <a id="1" class="A">X</a>
    <b id="2" class="B">Y</b>
    <c id="3" class="C">Z</c>
  </top>
</root>
}

@xml = Cherry::Xml.new( XDOC )

p @xml.search('top')

p @xml.search('top')[0]

p @xml.at('top')

