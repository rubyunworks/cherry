require 'test/unit'
require 'cherry/xml'

class Test_Cherry_Xml_1 < Test::Unit::TestCase

  S1 = %{
  <top>
    <a id="1" class="A">X</a>
    <b id="2" class="B">Y</b>
    <c id="3" class="C">Z</c>
  </top>
  }

  def setup
    @xml = Cherry::Xml.new( S1 )
  end

  def test_query_with_tag
    assert_equal( %{<a id="1" class="A">X</a>}, (@xml.query(:a)).to_s )
    assert_equal( %{<a id="1" class="A">X</a>}, (@xml / :a).to_s )
    assert_equal( %{<b id="2" class="B">Y</b>}, (@xml.query(:b)).to_s )
    assert_equal( %{<b id="2" class="B">Y</b>}, (@xml / :b).to_s )
    assert_equal( %{<c id="3" class="C">Z</c>}, (@xml.query(:c)).to_s )
    assert_equal( %{<c id="3" class="C">Z</c>}, (@xml / :c).to_s )
  end

  def test_query_with_id
    assert_equal( %{<a id="1" class="A">X</a>}, (@xml.query('#1')).to_s )
    assert_equal( %{<a id="1" class="A">X</a>}, (@xml / '#1').to_s )
    assert_equal( %{<b id="2" class="B">Y</b>}, (@xml.query('#2')).to_s )
    assert_equal( %{<b id="2" class="B">Y</b>}, (@xml / '#2').to_s )
    assert_equal( %{<c id="3" class="C">Z</c>}, (@xml.query('#3')).to_s )
    assert_equal( %{<c id="3" class="C">Z</c>}, (@xml / '#3').to_s )
  end

  def test_query_with_class
    assert_equal( %{<a id="1" class="A">X</a>}, (@xml.query('.A')).to_s )
    assert_equal( %{<a id="1" class="A">X</a>}, (@xml / '.A').to_s )
    assert_equal( %{<b id="2" class="B">Y</b>}, (@xml.query('.B')).to_s )
    assert_equal( %{<b id="2" class="B">Y</b>}, (@xml / '.B').to_s )
    assert_equal( %{<c id="3" class="C">Z</c>}, (@xml.query('.C')).to_s )
    assert_equal( %{<c id="3" class="C">Z</c>}, (@xml / '.C').to_s )
  end

end
