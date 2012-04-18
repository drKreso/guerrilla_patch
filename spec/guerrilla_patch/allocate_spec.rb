require 'guerrilla_patch/allocate'

describe Allocate do
  it 'should divide whole numbers' do
    subject.amount = 100
    subject.ratios = [0.1,0.9]
    subject.divided.should == [10, 90]
  end

  it 'should divide equally on two decimals' do
    subject.amount = 100
    subject.ratios = [1.0/3, 1.0/3,1.0/3]
    subject.divided.should == [33.33, 33.33, 33.34]
    subject.divided.inject(0) { | sum, item | sum += item }.should == subject.amount
  end

  it 'should calculate ratios if they are over 1' do
    subject.amount = 100
    subject.ratios = [50,70,90]
    subject.divided.should == [23.81, 33.33, 42.86 ]
    subject.divided.inject(0) { | sum, item | sum += item }.should == subject.amount
  end

  it 'should calculade real example' do
    subject.amount = 2297.19
    subject.ratios = [2170.29, 126.90 ]
    subject.divided.should == [2170.29, 126.90 ]
  end

  it 'should divide equally on number of slices' do
    Allocate.evenly(100,3).should == [33.33,33.33,33.34]
  end

  it 'should divide equally on number of slices for small number' do
    Allocate.evenly(0.1,3).should == [0.03,0.03,0.04]
  end

  it 'should divide equally on number of slices for really small number' do
    Allocate.evenly(0.1,9).should == [0.01,0.01,0.01,0.01,0.01,0.01,0.01,0.01,0.02]
  end

  it 'should divide equally on two decimals negative numbers' do
    subject.amount = -100
    subject.ratios = [1.0/3, 1.0/3,1.0/3]
    subject.divided.should == [-33.33, -33.33, -33.34]
    subject.divided.inject(0) { | sum, item | sum += item }.should == subject.amount
  end

  it 'should raise exception for number that is too small' do
    lambda do
      Allocate.evenly(0.1,20)
    end.should raise_error 'Number is too small to be allocated on that number of slices(0.1 on 20 slices).'
  end

  it 'should raise exception for number that is too small negative' do
    lambda do
      Allocate.evenly(-0.1,20)
    end.should raise_error 'Number is too small to be allocated on that number of slices(-0.1 on 20 slices).'
  end

  it 'should support costructor based params' do
    subject = Allocate.new( 100, [1.0/3, 1.0/3,1.0/3] )
    subject.divided.should == [33.33, 33.33, 33.34]
    subject.divided.inject(0) { | sum, item | sum += item }.should == subject.amount
  end

end 
