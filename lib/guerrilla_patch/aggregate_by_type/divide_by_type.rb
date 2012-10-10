class DivideByType
  def self.divide(ratios, amount)
    return {} if amount == 0
    ratios = { :no_division => 1 } if ratios == {}

    Hash[ ratios.each_key.zip(allocate(amount, ratios.each_value)) ]
  end

  private
  def self.allocate(amount, values)
    total = values.reduce(:+)
    amount.allocate( values.map { |amount| amount.to_d/total } )
  end
end
