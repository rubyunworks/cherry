module Cherry

  #
  class MissingImplemention < Exception
  end

  #
  class Base

    class << self

      # Alias original #new as #delegate.

      alias_method :delegate, :new

      # Create a new object from a File or other IO, or a String.

      def new(io_or_str, use_tidy=nil)
        #return self if io_or_str === self
        #a = adapter()

        if io_or_str.respond_to?(:read)
          str = io_or_str.read
          io_or_str.close rescue nil
        else
          str = io_or_str.to_s
        end

        if use_tidy
          doc = document(tidy(str, use_tidy))
        else
          doc = document(str)
        end

        delegate(doc.root)
      end

      # Load XML from file.

      def load(file)
        new(File.new(file))
      end

      # Tidy up XML is tidy is installed.

      def tidy(html, tidy_path=nil)
        require 'tidy'
        find_tidy( tidy_path )
        xml = Tidy.open(:show_warnings=>false) do |t|
          t.options.output_xml = true
          t.clean(html)
        end
      end

      # Try to find the tidy library.

      def find_tidy( tidy_path=nil )
        if String === tidy_path
          if File.exist?( tidy_path )
            return Tidy.path = tidy_path
          end
        end
        #tidylib.dll libtidy.dll
        %w{ libtidy.so tidylib.so }.each do |f|
          [ '/usr/lib', '/usr/local/lib' ].each do |d|
            try_file = File.join( d, 'libtidy.so' )
            if File.exist?(try_file)
              return Tidy.path = try_file
            end
          end
        end
        raise 'Tidy HTML library is unlocatable.'
      end

    end

    # Parse XML into underlying document.
    #
    def self.document(str)
      raise MissingImplemention
    end

    # instance methods ------------------------------

    # Access to the underlying node object.

    attr_reader :node

    #

    def initialize(node)
      @node = node
    end

    #
    #
    #def ==(other)
    #  @node.hash == other.node!.hash
    #end

    #

    #def inspect
    #  "<#{name}>...</>"
    #end

    # Create a new Xml object from a string.

    def xml(item)
      return item if object_class === item
      object_class.new(item)
    end

    # Create a new Xml object from a native node.

    def delegate(node)
      object_class.delegate(node)
    end

    #

    def to_s
      raise MissingImplemention
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
      @node
    end

    # Returns the tag name.

    def name
      @node.name
    end

    # Iterate over each child element.

    def each
      @node.each { |n| yield delegate(n) }
    end

    # Return Xml::Elements of all subnodes.

    def children
      Elements.new( @node.collect{ |n| delegate(n) } )
    end

    # Add a child node.

    def append(item)
      case item
      when object_class
        add_node(item.node)
      when Array, Elements
        item.each{ |x| add(x) }
      else
        add_text(item)
      end
      item
    end

    # TODO: Would this be better as add_text?
    alias_method :<<, :append

    # TODO: maybe deprecate #add
    alias_method :add, :append

    # TODO: write this method
    def prepend()

    end

    # Return the first child element that matches the give +tag+.

    def at(tag)
      search(tag)[0]
    end

    # XPath search.

    def search( xpath )
      raise MissingImplemention
    end

    # XPath or CSS search.

    def query(xpath)
      xpath = css_to_xpath(xpath)
      search(xpath)
    end

    # Alias for query.
    def /(xpath) #/
      xpath = css_to_xpath(xpath)
      search(xpath)
    end

    # Remove self from parent element.

    def remove!
      raise MissingImplemention
    end

    # Add child element.

    def add_node(node)
      raise MissingImplemention
    end

    private :add_node

    # Add text.

    def add_text(str)
      raise MissingImplemention
    end

    # Insert element(s) before this element.

    def before(item)
      raise MissingImplemention
    end

    # Insert element(s) after this element.

    def after(item)
      raise MissingImplemention
    end

    # Wrap an element around another.

    def wrap(item)
      raise MissingImplemention
    end

    # Copy elemet.

    def copy(deep=false)
      raise MissingImplemention
    end

    # Is the element empty?

    def empty?
      raise MissingImplemention
    end

    # Remove all of the element's children.

    def empty!
      raise MissingImplemention
    end

    # Access attribute.

    def [](attr)
      raise MissingImplemention
    end

    # Assign attribute.

    def []=(attr, str)
      raise MissingImplemention
    end

    # Set attributes.

    def set(hash)
      raise MissingImplemention
    end

    #

    def element?
      raise MissingImplemention
    end

    #

    def inner_xml(str)
      children.to_s
    end

    #

    def inner_xml=(str)
      empty!
      append(xml(str.to_s))
    end

    #

    def content=(item)
      empty!
      append(item)
    end

  private

    # Convert a CSS index to an XPath index.

    def css_to_xpath( css )
      case css.to_s
      when /^(\w*)([#.])(\w+)$/
        tag = ($1 == '' ? '*' : '')
        if $2 == '#'
          "#{tag}[@id='#{$3}']"
        else
          "#{tag}[@class='#{$3}']"
        end
      else
        css
      end
    end

    #def method_missing( sym, *args )
    #  self / sym
    #end

  end

  #
  class Base::Elements

    include Enumerable

    def initialize(list)
      @list = list
    end

    def first() @list.first end
    def last()  @list.last  end
    #def uniq!() @list.uniq! end

    def to_s()   @list.join end
    def to_a()   @list end
    def to_ary() @list end

    def [](index)
      @list[index]
    end

    #

    def each( &yld )
      @list.each( &yld )
    end

    #

    def search(xpath)
      l = []
      @list.each{ |node| l.concat( node.search(xpath) ) }
      self.class.new( l )
    end

    # Effectively an alias of #search.

    def query(xpath)
      l = []
      @list.each{ |node| l.concat( node.query(xpath) ) }
      self.class.new( l )
    end

    alias_method '/', :query

    #def /(xpath)
    #  l = []
    #  @list.each{ |node| l.concat( node / xpath) }
    #  self.class.new( l )
    #end

    # Set attributes.

    def set( hash )
      each { |e| e.set( hash ) }
    end

    #

    def remove!
      each { |e| e.remove! }
    end

    # Apply call to element in the list.
    #
    #def method_missing( sym, *args, &blk )
    #  l = []
    #  @list.each { |node| l.concat node.send(sym, *args, &blk) }
    #  self.class.new( l )
    #end

  end

end

