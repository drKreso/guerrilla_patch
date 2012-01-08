class String
  def split_on_size(*args)
    regex = args.to_a.inject('') { |regex, size| regex += "(\\w{#{size}})" }
    split(Regexp.compile("^#{regex}$")).reject do |item|
      item.blank? 
    end.join('-')
  end

  def upcase_roman
    self =~ /(.*)(_[xX]?[vV]?[iI]{0,3}[vV]?[xX]?)$/
    return self if $1.nil? || $2.nil?
    return $1 + $2.upcase
  end

  def indent
    tokens = self.split ("\n")
    result = ''
    if tokens.size > 0 
      prespace_index = tokens[0].index(/\S/)
      tokens.each do |token|
        result << token[prespace_index,(token.length - prespace_index)] << "\n"
      end
    end
    return result
  end
end

class Symbol
  def upcase_roman() self.to_s.upcase_roman end
end

class Object
 def class_name_upcase_roman() return self.class.to_s.underscore.upcase_roman.to_sym end
end

