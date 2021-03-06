require File.dirname(__FILE__) + '/spec_helper.rb'

describe "Frames" do

  before :all do
    @browser = Browser.new(BROWSER_OPTIONS)
  end

  describe "<frame> elements" do

    before :each do
      @browser.goto(HTML_DIR + "/frames.html")
    end

    describe "#length" do
      it "returns the correct number of frames" do
        @browser.frames.length.should == 2
      end
    end

    describe "#[]" do
      it "returns the frame at the given index" do
        @browser.frames[1].id.should == "frame_1"
      end
    end

    describe "#each" do
      it "iterates through frames correctly" do
        @browser.frames.each_with_index do |f, index|
          f.name.should == @browser.frame(:index, index+1).name
          f.id.should ==  @browser.frame(:index, index+1).id
          f.value.should == @browser.frame(:index, index+1).value
        end
      end
    end
  end

  describe "<iframe> elements" do

    before :each do
      @browser.goto(HTML_DIR + "/iframes.html")
    end

    describe "#length" do
      it "returns the correct number of frames" do
        @browser.frames.length.should == 2
      end
    end

    describe "#[]" do
      it "returns the frame at the given index" do
        @browser.frames[1].id.should == "frame_1"
      end
    end

    describe "#each" do
      it "iterates through frames correctly" do
        @browser.frames.each_with_index do |f, index|
          f.name.should == @browser.frame(:index, index+1).name
          f.id.should ==  @browser.frame(:index, index+1).id
          f.value.should == @browser.frame(:index, index+1).value
        end
      end
    end
  end

  after :all do
    @browser.close
  end

end