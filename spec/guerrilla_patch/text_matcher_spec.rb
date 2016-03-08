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

  it 'should recover after missing target' do
    source = { 1 => "Petar ide u ducan.", 2 => "Tamo je ludnica." }
    target = { 1 => "Petar ide u ducan.", 2 => "missing", 3=> "Tamo je ludnica." }
    TextMatcher.match(source,target).should == { 1 => [1], 3 => [2] }
  end

  it 'should recover after missing source' do
    source = { 1 => "Petar ide u ducan.", 2 => "missing", 3 => "Tamo je ludnica." }
    target = { 1 => "Petar ide u ducan.", 2=> "Tamo je ludnica." }
    TextMatcher.match(source,target).should == { 1 => [1], 2 => [3] }
  end

  it 'should recover after half missing source' do
    source = { 1 => "Petar ide u ducan. miss", 2 => "ing", 3 => "thisTamo je ludnica." }
    target = { 1 => "Petar ide u ducan.", 2=> "Tamo je ludnica." }
    TextMatcher.match(source,target).should == { 1 => [1], 2 => [3] }
  end

  it 'should recover after half missing both source and target' do
    source = { 1 => "Petar ide u ducan.", 2 => "thisTamo je ludnica." }
    target = { 1 => "Petar ide u ducan.kovic", 2=> "Tamo je ludnica." }
    TextMatcher.match(source,target).should == { 1 => [1], 2 => [2] }
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

  it 'should not skip too much but declare missing if present but far away' do
    source = { 1 => "Petar ide u ducan.", 2 => "Tamo je ludnica.", 3 => "missing" }
    target = { 1 => "Petar ide u ducan.", 2 => "missing", 3 => "Tamo je ludnica.", 4 => "missing" }
    TextMatcher.match(source,target).should == { 1 => [1], 2 => [], 3 => [2], 4 => [3] }
  end

  it 'supports this' do
    source = {7028=>"logotype_small", 7029=>"Testing formating.", 7030=>"row 1", 7031=>"row 1", 7032=>"row 2",
              7033=>"1", 7034=>"2", 7035=>"3", 7036=>"4", 7037=>"5", 7038=>"6", 7039=>"a", 7040=>"b", 7041=>"c",
              7042=>"d", 7043=>"e", 7044=>"f", 7045=>"g", 7046=>"h", 7047=>"i", 7048=>"Hello",
              7051=>"Testing formating.", 7052=>"row 1", 7053=>"row 1", 7054=>"row 2", 7055=>"1",
              7056=>"2", 7057=>"3", 7058=>"4", 7059=>"5", 7060=>"6", 7061=>"a1", 7062=>"b1", 7063=>"c1",
              7064=>"d1", 7065=>"e1", 7066=>"f1", 7067=>"g1", 7068=>"h1", 7069=>"i1", 7070=>"Hello",
              7073=>"logotype_small", 7050=>"(1) Mile voli disko ", 7072=>"(2) Mile voli disko drugi dio "}
    target = {586 => "\t\t\t\t\t", 587=>"Testing formating.", 588=>"row 1", 589=>"row 1", 590=>"row 2", 591=>"1", 592=>"2", 593=>"3",
              594=>"4", 595=>"5", 596=>"6", 597=>"a", 598=>"b", 599=>"c", 600=>"d", 601=>"e", 602=>"f", 603=>"g",
              604=>"h", 605=>"i", 606=>"Hello", 608=>"Testing formating.", 609=>"row 1", 610=>"row 1", 611=>"row 2",
              612=>"1", 613=>"2", 614=>"3", 615=>"4", 616=>"5", 617=>"6", 618=>"a1", 619=>"b1", 620=>"c1", 621=>"d1",
              622=>"e1", 623=>"f1", 624=>"g1", 625=>"h1", 626=>"i1", 627=>"Hello", 628=>"  Mile voli disko",
              629=>"  Mile voli disko drugi dio", 630=>"FOOTER 1" }
    result = TextMatcher.match(source,target)
    result.should == {587=>[7029], 588=>[7030], 589=>[7031], 590=>[7032], 591=>[7033], 592=>[7034], 593=>[7035],
       594=>[7036], 595=>[7037], 596=>[7038], 597=>[7039], 598=>[7040], 599=>[7041], 600=>[7042],
       601=>[7043], 602=>[7044], 603=>[7045], 604=>[7046], 605=>[7047], 606=>[7048], 608=>[7051],
       609=>[7052], 610=>[7053], 611=>[7054], 612=>[7055], 613=>[7056], 614=>[7057], 615=>[7058],
       616=>[7059], 617=>[7060], 618=>[7061], 619=>[7062], 620=>[7063], 621=>[7064], 622=>[7065],
       623=>[7066], 624=>[7067], 625=>[7068], 626=>[7069], 627=>[7070], 628=>[7050], 629=>[7072]}
  end

end
