require 'guerrilla_patch/string.rb'

describe String do
  it 'should create proper class name' do
   'mile_i'.upcase_roman.should == 'mile_I'
   :mile_ii.upcase_roman.should == 'mile_II'
   :mile_iii.upcase_roman.should == 'mile_III'
   :mile_iv.upcase_roman.should == 'mile_IV'
   'mile_v'.upcase_roman.should == 'mile_V'
   'mile_vi'.upcase_roman.should == 'mile_VI'
   'mile_vii'.upcase_roman.should == 'mile_VII'
   'mile_viii'.upcase_roman.should == 'mile_VIII'
   'mile_ix'.upcase_roman.should == 'mile_IX'
   'mile_x'.upcase_roman.should == 'mile_X'
   'mile_xi'.upcase_roman.should == 'mile_XI'
   'mile_xii'.upcase_roman.should == 'mile_XII'
   'mile_xiii'.upcase_roman.should == 'mile_XIII'
   'mile_xiv'.upcase_roman.should == 'mile_XIV'
   'mile_xv'.upcase_roman.should == 'mile_XV'
   'mile_xvi'.upcase_roman.should == 'mile_XVI'
   'mile_xvii'.upcase_roman.should == 'mile_XVII'
   'mile_xviii'.upcase_roman.should == 'mile_XVIII'
   'mile_xix'.upcase_roman.should == 'mile_XIX'
   'mile_xx'.upcase_roman.should == 'mile_XX'
  end

  it 'should recognize mixed case' do
   'mile_xvIii'.upcase_roman.should == 'mile_XVIII'
   'mile_xiX'.upcase_roman.should == 'mile_XIX'
   'mile_xX'.upcase_roman.should == 'mile_XX'
  end

  it 'should know to indent' do
    a = "          kreso\n            subitem\n          peer\n"
    a.indent.should == "kreso\n  subitem\npeer\n"
  end

  it 'should know to indent special char %' do
    a = "          %kreso\n            subitem\n          peer\n"
    a.indent.should == "%kreso\n  subitem\npeer\n"
  end

  it 'should know to indent special char =' do
    a = "          =kreso\n            subitem\n          peer\n"
    a.indent.should == "=kreso\n  subitem\npeer\n"
  end

  it 'should know to indent special char -' do
    a = "          -kreso\n            subitem\n          peer\n"
    a.indent.should == "-kreso\n  subitem\npeer\n"
  end

end
