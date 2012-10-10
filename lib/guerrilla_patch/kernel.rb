require 'bigdecimal'
require 'guerrilla_patch/allocate'

module Kernel
  def let(name, &block)
    define_method(name, &block)
  end

  def let_self(name, &block)
    define_singleton_method(name, &block)
  end

  def when_present(item, &block)
    if block_given?
      item.nil? ? '' : block.call(item)
    else
      item
    end
  end

  def consists_of
    PoorsManStringBuilder.new.tap { |builder| yield(builder) }.result
  end

  class PoorsManStringBuilder
    attr_reader :result

    def initialize
      @result = ''
    end

    def add(item)
      @result << item.to_s
    end
    alias :always :add

    def when_present(item, &block)
      @result << Kernel.when_present(item, &block).to_s
    end

    def when(item, &block)
      return unless item
      @result << Kernel.when_present(item, &block).to_s
    end
  end
end

#add sum_me to array, with or without name
class Array
  def sum_me(name = nil)
    self.map(&name).reduce(0, :+)
  end
end

class Hash
  def negative
    Hash[self.map { |key,value| [key, -value]}]
  end
end

class Fixnum
  def negative
    -self
  end
end

class Hash
  def sum_me
    self.each_value.reduce(0,:+)
  end
end


module Kernel
  def to_d
    BigDecimal.new(self.to_s)
  end

  def allocate_evenly(number_of_slices)
    Allocate.evenly(self.to_d, number_of_slices)
  end

  def allocate(ratios)
    Allocate.new(self.to_d, ratios).divided
  end
end



