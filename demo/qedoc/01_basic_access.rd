= Basic Access

Require Cherry XML.

    require 'cherry/xml'

We will use this simple document to demonstrate access.

    x = %{
      <root>
        <top>
          <a id="1" class="A">X</a>
          <b id="2" class="B">Y</b>
          <c id="3" class="C">Z</c>
        </top>
      </root>
    }

    @xml = Cherry::Xml.new(x)

== #query

We can use #query to access nodes by tag name.

    @xml.query('a').to_s.should == %{<a id="1" class="A">X</a>} 
    @xml.query('b').to_s.should == %{<b id="2" class="B">Y</b>}
    @xml.query('c').to_s.should == %{<c id="3" class="C">Z</c>}

We can use #query to access nodes by id.

    @xml.query('#1').to_s.should == %{<a id="1" class="A">X</a>}
    @xml.query('#2').to_s.should == %{<b id="2" class="B">Y</b>}
    @xml.query('#3').to_s.should == %{<c id="3" class="C">Z</c>}

And we can use #query to access node by class name.

    @xml.query('.A').to_s.should == %{<a id="1" class="A">X</a>} 
    @xml.query('.B').to_s.should == %{<b id="2" class="B">Y</b>}
    @xml.query('.C').to_s.should == %{<c id="3" class="C">Z</c>}

== #/

We can also use #/ to access nodes by tag name.

    (@xml / :a).to_s.should == %{<a id="1" class="A">X</a>}
    (@xml / :b).to_s.should == %{<b id="2" class="B">Y</b>}
    (@xml / :c).to_s        == %{<c id="3" class="C">Z</c>}

We can use #/ to access nodes by id.

    (@xml / '#1').to_s.should == %{<a id="1" class="A">X</a>}
    (@xml / '#2').to_s.should == %{<b id="2" class="B">Y</b>}
    (@xml / '#3').to_s.should == %{<c id="3" class="C">Z</c>}

And we can use #/ to access node by class name.

    (@xml / '.B').to_s.should == %{<b id="2" class="B">Y</b>}
    (@xml / '.A').to_s.should == %{<a id="1" class="A">X</a>}
    (@xml / '.C').to_s.should == %{<c id="3" class="C">Z</c>}

== #[]

The #[] method can be used to access child nodes by their numerical order.

    @xml.query('top')[0].to_s.should == %{<a id="1" class="A">X</a>} 

QED.

