module Kernel
   def let(name, &block)
     define_method(name, &block)
   end

   def let_self(name, &block)
     define_singleton_method(name, &block)
   end
end
