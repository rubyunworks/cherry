require 'test/unit'
require 'cherry/xml'

class Test_Cherry_Xml_2 < Test::Unit::TestCase

  XDOC = %{
  <top xmlns:x="http://www.foo.org/">
    <x:a id="1" class="A">X</x:a>
    <x:b id="2" class="B">Y</x:b>
    <x:c id="3" class="C">Z</x:c>
  </top>
  }

  def setup
    @xml = Cherry::Xml.new( XDOC )
  end

  def test_001
    assert_equal( %{<x:a id="1" class="A">X</x:a>}, (@xml.query('x:a')).to_s )
    assert_equal( %{<x:a id="1" class="A">X</x:a>}, (@xml / 'x:a').to_s )
    assert_equal( %{<x:b id="2" class="B">Y</x:b>}, (@xml.query('x:b')).to_s )
    assert_equal( %{<x:b id="2" class="B">Y</x:b>}, (@xml / 'x:b').to_s )
    assert_equal( %{<x:c id="3" class="C">Z</x:c>}, (@xml.query('x:c')).to_s )
    assert_equal( %{<x:c id="3" class="C">Z</x:c>}, (@xml / 'x:c').to_s )
  end

  def test_002
    #assert_equal( %{<a id="1" class="A">X</a>}, (@xml.query('#1')).to_s )
    assert_equal( %{<x:a id="1" class="A">X</x:a>}, (@xml / '#1').to_s )
    #assert_equal( %{<b id="2" class="B">Y</b>}, (@xml.query('#2')).to_s )
    assert_equal( %{<x:b id="2" class="B">Y</x:b>}, (@xml / '#2').to_s )
    #assert_equal( %{<c id="3" class="C">Z</c>}, (@xml.query('#2')).to_s )
    assert_equal( %{<x:c id="3" class="C">Z</x:c>}, (@xml / '#3').to_s )
  end

  def test_003
    #assert_equal( %{<a id="1" class="A">X</a>}, (@xml.query('.A')).to_s )
    assert_equal( %{<x:a id="1" class="A">X</x:a>}, (@xml / '.A').to_s )
    #assert_equal( %{<b id="2" class="B">Y</b>}, (@xml.query('.B')).to_s )
    assert_equal( %{<x:b id="2" class="B">Y</x:b>}, (@xml / '.B').to_s )
    #assert_equal( %{<c id="3" class="C">Z</c>}, (@xml.query('.C')).to_s )
    assert_equal( %{<x:c id="3" class="C">Z</x:c>}, (@xml / '.C').to_s )
  end

end
