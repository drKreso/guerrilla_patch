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
