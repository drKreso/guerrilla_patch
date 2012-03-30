require 'guerrilla_patch/kernel.rb'

describe Kernel do
  
  it 'wraps commnon nil object idiom' do
    test_object = nil
    when_present(test_object) { |t| t }.should == ''
    test_object = 'I am here'
    when_present(test_object) { |t| t }.should == 'I am here'
  end

  it 'takes the block result and concatenates' do
    test_object = 'I am here'
    when_present(test_object) { |t| t * 2 }.should == 'I am hereI am here'
  end

  it 'behaves graceafully when no block is given' do
    test_object = "miki"
    when_present(test_object).should == test_object
  end

  it 'concatenates result to one string' do
    consists_of do |r|
      r.add "AAAAAA"
      r.add "BBBBBB"
    end.should == "AAAAAABBBBBB"
  end

  it 'concatenates result to one string taking care of nil objects' do
    test_object = nil
    consists_of do |r|
      r.always "AAAAAA"
      r.always "BBBBBB"
      r.when_present(test_object) { |to| to << "BABY"}
    end.should == "AAAAAABBBBBB"

    test_object = 'YEAH'
    consists_of do |r|
      r.add "AAAAAA"
      r.add "BBBBBB"
      r.when_present(test_object) { |to| to << "BABY"}
    end.should == "AAAAAABBBBBBYEAHBABY"
  end

  it 'concatenates result when item is true' do
    test_object = nil
    consists_of do |r|
      r.add "AAAAAA"
      r.when(test_object) { "BBBBBB" }
    end.should == "AAAAAA"

    test_object = true
    consists_of do |r|
      r.add "AAAAAA"
      r.when(test_object) { "BBBBBB" }
    end.should == "AAAAAABBBBBB"

    test_object = false
    consists_of do |r|
      r.add "AAAAAA"
      r.when(test_object) { "BBBBBB" }
    end.should == "AAAAAA"

  end



end