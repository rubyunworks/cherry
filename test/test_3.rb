require 'test/unit'
require 'cherry/xml'

class Test_Cherry_Xml_3 < Test::Unit::TestCase

  XDOC = %{
  <top>
    <a id="1" class="A">X</a>
    <b id="2" class="B">Y</b>
    <c id="3" class="C">Z</c>
  </top>
  }

  def setup
    @xml = Cherry::Xml.new( XDOC )
  end

  def test_at
    assert_equal( @xml.search('top')[0], @xml.at('top') )
  end

  def test_002
    #assert_equal( %{<a id="1" class="A">X</a>}, (@xml.query('#1')).to_s )
    #assert_equal( %{<x:a id="1" class="A">X</x:a>}, (@xml / '#1').to_s )
    #assert_equal( %{<b id="2" class="B">Y</b>}, (@xml.query('#2')).to_s )
    #assert_equal( %{<x:b id="2" class="B">Y</x:b>}, (@xml / '#2').to_s )
    #assert_equal( %{<c id="3" class="C">Z</c>}, (@xml.query('#2')).to_s )
    #assert_equal( %{<x:c id="3" class="C">Z</x:c>}, (@xml / '#3').to_s )
  end

  def test_003
    #assert_equal( %{<a id="1" class="A">X</a>}, (@xml.query('.A')).to_s )
    #assert_equal( %{<x:a id="1" class="A">X</x:a>}, (@xml / '.A').to_s )
    #assert_equal( %{<b id="2" class="B">Y</b>}, (@xml.query('.B')).to_s )
    #assert_equal( %{<x:b id="2" class="B">Y</x:b>}, (@xml / '.B').to_s )
    #assert_equal( %{<c id="3" class="C">Z</c>}, (@xml.query('.C')).to_s )
    #assert_equal( %{<x:c id="3" class="C">Z</x:c>}, (@xml / '.C').to_s )
  end

end
