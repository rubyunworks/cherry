require 'cherry/adapter/base'
require 'rexml/document'

module Cherry

  # = Rexml
  #
  class Rexml < Base

    def self.document(str)
      ::REXML::Document.new(str)
    end

    #def self.load(file)
    #  ::REXML::Document.new(File.new(file)).root
    #end

    #

    def to_s
      @node.text
    end

    # FIXME
    def to_s
      @node.to_s
    end

    #

    def to_xml
      @node.to_s
    end

    # TODO: Only appy to root? How to deal with?
    def document
      @node.document
    end

    # Returns the tag name.

    def name
      @node.name
    end

    # XPath search.

    def search(xpath)
      list = ::REXML::XPath.match( @node, xpath.to_s ).collect { |n| delegate(n) }
      Elements.new( list )
    end

    # Remove this node from it's parent.

    def remove!
      case @node.node_type
      when :text
        @node.value = ''
      else
        @node.parent.send("delete_#{@node.node_type}", @node )
      end
      self
    end

    # Add child element node.

    def add_node(node)
      @node.send("add_#{node.node_type}", node)
      node
    end

    # Add text.

    def add_text( str )
      @node.add_text( str.to_s )
    end

    # Insert element(s) before this element.

    def before( item )
      case item
      when object_class
        @node.parent.insert_before( @node, item.node )
      when Array, Elements
        item.reverse_each { |i| before( i ) }
      else
        @node.parent.insert_before @node, xml( item )
      end
    end

    # Insert element(s) after this element.

    def after( item )
      case item
      when object_class
        @node.parent.insert_after( @node, item.node )
      when Array, Elements
        item.each { |i| after( i ) }
      else
        @node.parent.insert_after @node, xml(item).node
      end
    end

    # Wrap an element around this element.

    def wrap( item )
      unless object_class === item
        item = xml(item)
      end
      @node.parent.insert_after @node, item.node
      item.append @node
      remove!
      item
    end

    # Copy elemet.

    def copy( deep=false )
      if deep
        delegate(@node.deep_clone)
      else
        delegate(@node.clone)
      end
    end

    # Is the element empty?

    def empty?
      case @node
      when ::REXML::Element
        @node.size == 0
      when ::REXML::Text
        @node.value == ''
      else
        nil
      end
    end

    # Remove all of the element's children.

    def empty!
      case @node
      when ::REXML::Element
        each { |n| n.remove! }
      when ::REXML::Text
        @node.value = ''
      else
        nil
      end
    end

    # Access attribute.

    def [](attr)
      @node.attribute(attr).value
    end

    # Assign attribute.

    def []=(attr, str)
      @node.add_attribute(attr, str)
    end

    # Set attributes.

    def set( hash )
      hash.each do |k,v|
        @node.add_attribute(attr, str)
      end
    end

    #

    def element?
      ::REXML::Element === @node
    end

  end#class Rexml

end#module Cherry

