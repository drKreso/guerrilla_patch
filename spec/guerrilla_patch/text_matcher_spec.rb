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

  it 'should pair when index is bigger than single digit number' do
    source = { 1 => "A", 2 => "B", 3 => "C", 4 => "D", 5 => "EF", 6 => "G", 7 => "H", 8 => "I",
               9 => "J", 10 => "KL", 11 => "M",  12 => "N", 13 => "O" }
    target = { 1 => "A", 2 => "B", 3 => "C", 4 => "D", 5 => "E", 6 => "FG", 7 => "H", 8 => "I",
               9 => "J", 10 => "K", 11 => "LM",  12 => "N", 13 => "O" }
    TextMatcher.match(source,target).should == { 1=>[1], 2=>[2], 3=>[3], 4=>[4], 5=>[5], 6=>[5, 6],
                                                 7=>[7], 8=>[8], 9=>[9], 10=>[10], 11=>[10, 11],
                                                 12=>[12], 13=>[13]
                                               }
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
