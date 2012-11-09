require 'guerrilla_patch/aggregate_by_type/divide_by_type'

describe DivideByType do
  before(:each) do
    @ratios = { '1A' => 50, '1B' => 30, '1C' => 20 }
  end

  it 'knows ratios' do
    DivideByType.divide(@ratios, 50).should ==
      {'1A' => 25, '1B' => 15, '1C' => 10}
  end

  it 'knows ratios for negative values' do
    DivideByType.divide(@ratios, -50).should ==
      {'1A' => -25, '1B' => -15, '1C' => -10}
  end

  it 'returns empty dividis for zero' do
    DivideByType.divide(@ratios, 0).should == {}
  end

  it 'knows how to divide without ratios' do
    DivideByType.divide({}, 10).should == { :no_division => 10}
  end

  it 'knows how to divide negative ratios' do
     DivideByType.divide({"E2112"=>279.37, "E2111"=>-233.06}, 46.31).should == { "E2112" => 279.37, "E2111" => -233.06 }
  end
end

