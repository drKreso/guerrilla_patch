require_relative 'divide_by_type'
require_relative 'amount'

class Aggregator
  def self.agregate(&block)
    agregator = Aggregator.new
    block.call(agregator)
    return Amount.new(agregator.total,agregator.total_by_type)
  end

  def add(amount)
    total_list << Aggregator.prepare(amount)
  end

  def subtract(amount)
    add(amount.negative)
  end

  def total
    (by_type? ? total_by_type : total_list).sum_me
  end

  def total_by_type
    Aggregator.agregate_by_type(total_list)
  end

  private

  def by_type?
    return false if @total_list == []

    total_list[0].class == Hash
  end

  def total_list
    @total_list ||= []
  end

  #hey don't judge me, yes I know I am a bad man
  def self.agregate_by_type(lista)
   return {} if lista[0].class != Hash

   result = lista.inject { |memo, el| self.merge_by_key(memo, el) }
   (result.nil? ? {} : result).reject { |key, value| value == 0 }
  end

  def self.merge_by_key(memo, el)
    memo.merge( el ) { |key, old_v, new_v| old_v + new_v }
  end

  def self.prepare(amount)
    amount.class == Amount ? amount.divide : amount
  end
end #Agregator
