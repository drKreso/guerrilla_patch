require 'guerrilla_patch/text_matcher.rb'

describe TextMatcher  do

  it 'should pair exact matches' do
    source = { 1 => "Petar ide u ducan.", 2 => "Tamo je ludnica"}
    target = { 1 => "Petar ide u ducan.", 2 => "Tamo je ludnica"}
    TextMatcher.match(source,target).should == { 1 => [1], 2 => [2] }
  end

  it 'should pair exact matches' do
    source = { 1 => "Petar ide u ducan.", 2 => "Tamo je ludnica.", 3=> "Sve je na popustu."}
    target = { 1 => "Petar ide u ducan.", 2 => "Tamo je ludnica.", 3=> "Sve je na popustu."}
    TextMatcher.match(source,target).should == { 1 => [1], 2 => [2], 3 => [3]  }
  end

  it 'should pair two for one target' do
    source = { 1 => "Petar ide u ducan.", 2 => "Tamo je ludnica." }
    target = { 1 => "Petar ide u ducan.Tamo je ludnica." }
    TextMatcher.match(source,target).should == { 1 => [1, 2] }
  end

  it 'should pair mismatced case' do
    source = { 1 => "Petar ide u Ducan.", 2 => "Tamo je ludnica." }
    target = { 1 => "Petar ide u ducan.Tamo je ludnica." }
    TextMatcher.match(source,target).should == { 1 => [1, 2] }
  end

  it 'should pair two for one target and continue matching' do
    source = { 1 => "Petar ide u ducan.", 2 => "Tamo je ludnica.", 3 => "A" }
    target = { 1 => "Petar ide u ducan.Tamo je ludnica.", 2 => "A" }
    TextMatcher.match(source,target).should == { 1 => [1, 2], 2 => [3] }
  end

  it 'should pair two for one target regardless of spacing' do
    source = { 1 => "Petar ide u ducan.", 2 => "Tamo je ludnica." }
    target = { 1 => "Petar ide u  ducan. Tamo je ludnica." }
    TextMatcher.match(source,target).should == { 1 => [1, 2] }
  end

  xit 'should recover after missing target' do
    source = { 1 => "Petar ide u ducan.", 2 => "Tamo je ludnica." }
    target = { 1 => "Petar ide u ducan.", 2 => "missing", 3=> "Tamo je ludnica." }
    TextMatcher.match(source,target).should == { 1 => [1], 2 => [], 3 => [2] }
  end

  xit 'should recover after missing source' do
    source = { 1 => "Petar ide u ducan.", 2 => "missing", 3 => "Tamo je ludnica." }
    target = { 1 => "Petar ide u ducan.", 2=> "Tamo je ludnica." }
    TextMatcher.match(source,target).should == { 1 => [1], 2 => [3] }
  end

  it 'should recover on half match' do
    source = { 1 => "Petar ide u ducan.", 2 => "Tamo je ludnica.", 3 => "Ovo je ok.", 4 => "Sadrzi zadnje dvije." }
    target = { 1 => "Petar ide u ducan. Tamo", 2=> "je ludnica." , 3 => "Ovo je ok. Sadrzi zadnje dvije." }
    TextMatcher.match(source,target).should == { 1 => [1,2], 2 => [2], 3 => [3,4] }
  end

  it 'should recover on half match from source side' do
    source = { 1 => "Petar ide u ducan. Tamo", 2 => "je ludnica.", 3 => "Ovo je ok.", 4 => "Sadrzi zadnje dvije." }
    target = { 1 => "Petar ide u ducan.", 2=> "Tamo je ludnica." , 3 => "Ovo je ok. Sadrzi zadnje dvije." }
    TextMatcher.match(source,target).should == { 1 => [1], 2 => [1,2], 3 => [3,4] }
  end

end
