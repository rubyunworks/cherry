require 'cherry/adapter/base'
require 'nokogiri'

# class XML::Node
#   alias_method :append, :<<
#   def <<( node )
#     if Array === node
#       node.each { |n| self.append n }
#     else
#       append( node )
#     end
#   end
# end

module Cherry

  # = Libxml
  #
  class Nokogiri < Base

    def self.document(str)
      ::Nokogiri::XML(str)
    end

    # Return the first child element that matches the give +tag+.

    def at(tag)
      delegate(@node.find_first(tag))
    end

    #

    def to_s
      @node.content
    end

    # FIXME
    def to_s
      @node.to_s
    end

    #

    def to_xml
      @node.to_s
    end

    # FIXME
    def document
      @node #.document
    end

    # Returns the tag name.

    def name
      @node.name
    end

    # XPath search.

    def search(xpath)
      list = @node.search(xpath.to_s).to_a.collect { |n| delegate(n) }
      Elements.new( list )
    end

    # XPath or CSS search.

    def query(xpath_or_css)
      #xpath = css_to_xpath(xpath)
      #search(xpath_or_css)
      list = @node.search(xpath_or_css.to_s).to_a.collect{ |n| delegate(n) }
      Elements.new(list)
    end

    # Remove self from parent element.

    def remove!
      @node.remove!
    end

    # Add node.

    def add_node(node)
      @node << node
    end

    # Add text.

    def add_text( str )
      @node << str.to_s
    end

    # Insert element(s) before this element.

    def before(item)
      case item
      when object_class
        @node.parent.insert_before( @node, item.node )
      when Array, Elements
        item.reverse_each { |i| before( i ) }
      else
        @node.parent.insert_before @node, xml(item).node
      end
    end

    # Insert element(s) after this element.

    def after(item)
      case item
      when object_class
        @node.sbiling( item.node )
      when Array, Elements
        item.each { |i| after( i ) }
      else
        @node.sibling xml(item).node
      end
    end

    # Wrap an element around another.

    def wrap( item )
      unless object_class === item
        item = xml(item)
      end
      @node.sibling item.node
      item.append @node
      remove!
      item
    end

    # Copy elemet.

    def copy( deep=false )
      delegate(@node.copy(deep))
    end

    # Is the element empty?

    def empty?
      @node.empty?
    end

    # Remove all of the element's children.

    def empty!
      @node.each { |n| n.remove! }
    end

    # Access attribute.

    def [](attr)
      @node[attr]
    end

    # Assign attribute.

    def []=(attr, str)
      @node[attr] = str
    end

    # Set attributes.

    def set( hash )
      hash.each do |k,v|
        @node[attr] = str
      end
    end

    #

    def element?
      @node.element?
    end

  end#class Nokogiri

end#module Cherry

