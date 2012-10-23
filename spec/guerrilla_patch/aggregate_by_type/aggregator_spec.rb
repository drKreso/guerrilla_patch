require 'guerrilla_patch/aggregate_by_type/aggregator'

describe Aggregator do
  it 'knows how to add regular number' do
    amount = Aggregator.aggregate do |result|
      result.add 1
      result.add 2
    end

    amount.value.should == 3
    amount.by_type.should == {}
  end

  it 'knows how to subtract regular number' do
    amount = Aggregator.aggregate do |result|
      result.add 1
      result.subtract 2
    end

    amount.value.should == -1
    amount.by_type.should == {}
  end

  it 'knows how to add amount with regular number' do
    amount = Aggregator.aggregate do |result|
      result.add Amount.new(1, {})
      result.add Amount.new(2, {})
    end

    amount.value.should == 3
    amount.by_type.should == { :no_division => 3 }
  end

  it 'knows how to add amount with full precision' do
    amount = Aggregator.aggregate do |result|
      result.subtract_full_precision Amount.new("0.001".to_d, {'1B' => "0.001".to_d})
      result.add_full_precision Amount.new("1.123".to_d, { "1A" => "1.123".to_d})
      result.add_full_precision Amount.new("2.222".to_d, { "1B" => "2.222".to_d})
      result.subtract_full_precision Amount.new("0.001".to_d, {'1C' => "0.001".to_d})
    end

    amount.value.should == 3.343
    amount.by_type.should == { '1A' => "1.123".to_d, '1B' => "2.221".to_d, '1C' => "-0.001".to_d }
  end

  it 'knows how to add amount of integer type' do
    amount = Aggregator.aggregate do |result|
      result.add Amount.new(1, {'1A' => 1})
      result.add Amount.new(2, {'1B' => 1})
    end

    amount.value.should == 3
    amount.by_type.should == { '1A' => 1, '1B' => 2}
  end

  it 'knows how to add amount of bigdecimal type' do
    amount = Aggregator.aggregate do |result|
      result.add Amount.new(1.0.to_d, {'1A' => 1})
      result.subtract Amount.new(2.2.to_d, {'1B' => 1})
    end

    amount.value.should == -1.2
    amount.by_type.should == { '1A' => 1, '1B' => -2.2}
  end

  it 'knows how to subtract floats amounts' do
    amount = Aggregator.aggregate do |result|
      result.add Amount.new(1.0, {'1A' => 1})
      result.subtract Amount.new(2.2, {'1B' => 1})
    end

    amount.value.should == -1.2
    amount.by_type.should == { '1A' => 1.0, '1B' => -2.2}
  end

  it 'knows how to subtract integer amounts' do
    amount = Aggregator.aggregate do |result|
      result.add Amount.new(1, {'1A' => 1})
      result.subtract Amount.new(2, {'1B' => 1})
    end

    amount.value.should == -1
    amount.by_type.should == { '1A' => 1, '1B' => -2}
  end

  it 'knows how to add by type' do
   amount =  Aggregator.aggregate do |result|
      result.add({ '1A' => 75 })
      result.add({ '1A' => 25 })
    end

   amount.value.should == 100
   amount.by_type.should == { '1A' => 100 }
  end

  it 'knows how to subtract by value' do
   amount =  Aggregator.aggregate do |result|
      result.add({ '1A' => 75 })
      result.subtract({ '1A' => 25 })
    end

   amount.value.should == 50
   amount.by_type.should == { '1A' => 50 }
  end
end
