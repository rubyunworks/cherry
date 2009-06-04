module Cherry

  #
  class Elements

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

    # TODO: should this be this index or the children of each listed node?
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

