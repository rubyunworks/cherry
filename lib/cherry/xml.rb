require 'cherry/core_ext/kernel'

module Cherry

  # Set the adapter, either rexml or libxml.
  #
  def self.adapter(name=nil)
    return @adapter if @adapter
    if name
      require "cherry/adapter/#{name}"
      adapter = Cherry.const_get(name.to_s.upcase)
    else
      begin
        require "cherry/adapter/libxml"
        adapter = Libxml
      rescue
        require "cherry/adapter/rexml"
        adapter = Rexml
      end
    end
    #Xml.class_eval{ include adapter }
    @adapter = adapter
  end

  # Functional shortcut to Xml.new.
  #
  def Xml(io_or_str)
    Xml.new(io_or_str)
  end

  # = Xml
  #
  # Xml class is actually a factory.
  # Depending on which adapter is used it will
  # provide the adapted version.
  #
  class Xml

    def self.adapter(type=nil)
      Cherry.adapter(type)
    end

    def self.new(io_or_str)
      adapter.new(io_or_str)
    end

    def self.load(file)
      adapter.load(file)
    end

  end

end

