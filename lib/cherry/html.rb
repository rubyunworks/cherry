require 'xcherry/xml'
require 'tidy'

#Tidy.path = '/usr/lib/tidylib.so'

module Cherry

  # = Html
  #
  # TODO: This is a work in progress.
  #
  class Html < Xml

    def self.new( io_or_str )
      #return self if io_or_str === self
      a = adapter
      if io_or_str.respond_to?(:read)
        node = a.parse( io_or_str.read )
        io_or_str.close rescue nil
      else
        node = a.parse( io_or_str.to_s )
      end
      delegate( node )
    end

  end

end
