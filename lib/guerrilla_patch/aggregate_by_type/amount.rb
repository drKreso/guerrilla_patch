class Amount
  attr_reader :value, :by_type
  def initialize(value, by_type)
    @value = value
    @by_type = by_type
  end

  def ==(other)
    self.value == other.value && self.by_type == other.by_type
  end

  def inspect
    consists_of do |result|
      result.add value_display
      result.when(by_type_display != '') { ", #{by_type_display}"}
    end
  end

  def negative
    Amount.new(-value, by_type)
  end

  def divide
    value.divide by_type
  end

  private
  def value_display
    value.to_f
  end

  def by_type_display
    by_type.map { |key, value| "#{key} => #{value.to_f}" }.join(", ")
  end
end #Amount
