class Allocate
  attr_accessor :amount
  attr_accessor :ratios

  def initialize(amount = 0 , ratios = [])
    @amount = amount
    @ratios = ratios
  end

  def divided
    divided_ratios = @ratios.map { |ratio| ratio.to_d/ratios.sum.to_d }
    compensate_last_slice( divided_ratios.map { |ratio| (@amount * ratio).round(2) } )
  end
  
  def compensate_last_slice(rates)
    rates.tap do |rates|
      rates[-1] = rates[-1] + (amount - rates.sum).round(2)
      if ( amount > 0 && ( rates.select {|item| item <= 0 }.count > 0 ) ) ||
         ( amount < 0 && ( rates.select {|item| item >= 0 }.count > 0 ) )
        raise "Number is too small to be allocated on that number of slices(#@amount on #{@ratios.size} slices)."
      end
    end
  end

  def self.evenly(amount, number_of_slices)
    Allocate.new.tap do |a|
      a.amount = amount
      a.ratios = (1..number_of_slices).map { 1.to_d/number_of_slices }
    end.divided
  end
end #Allocate
