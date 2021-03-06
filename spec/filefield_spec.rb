require File.dirname(__FILE__) + '/spec_helper.rb'

describe "FileField" do
  before :all do
    @browser = Browser.new(BROWSER_OPTIONS)
  end

  before :each do
    @browser.goto(HTML_DIR + "/forms_with_input_elements.html")
  end

  describe "#exist?" do
    it "returns true if the file field exists" do
      @browser.file_field(:id, 'new_user_portrait').should exist
      @browser.file_field(:id, /new_user_portrait/).should exist
      @browser.file_field(:name, 'new_user_portrait').should exist
      @browser.file_field(:name, /new_user_portrait/).should exist
      @browser.file_field(:class, 'portrait').should exist
      @browser.file_field(:class, /portrait/).should exist
      @browser.file_field(:index, 1).should exist
      @browser.file_field(:xpath, "//input[@id='new_user_portrait']").should exist
    end

    it "returns true if the element exists (default how = :name)" do
      @browser.file_field("new_user_portrait").should exist
    end

    it "returns false if the file field doesn't exist" do
      @browser.file_field(:id, 'no_such_id').should_not exist
      @browser.file_field(:id, /no_such_id/).should_not exist
      @browser.file_field(:name, 'no_such_name').should_not exist
      @browser.file_field(:name, /no_such_name/).should_not exist
      @browser.file_field(:class, 'no_such_class').should_not exist
      @browser.file_field(:class, /no_such_class/).should_not exist
      @browser.file_field(:index, 1337).should_not exist
      @browser.file_field(:xpath, "//input[@id='no_such_id']").should_not exist
    end

    it "raises TypeError when 'what' argument is invalid" do
      lambda { @browser.file_field(:id, 3.14).exists? }.should raise_error(TypeError)
    end

    it "raises MissingWayOfFindingObjectException when 'how' argument is invalid" do
      lambda { @browser.file_field(:no_such_how, 'some_value').exists? }.should raise_error(MissingWayOfFindingObjectException)
    end
  end

  # Attribute methods

  describe "#class_name" do
    it "returns the class attribute if the text field exists" do
      @browser.file_field(:index, 1).class_name.should == "portrait"
    end

    it "raises UnknownObjectException if the text field doesn't exist" do
      lambda { @browser.file_field(:index, 1337).class_name }.should raise_error(UnknownObjectException)
    end
  end

  describe "#id" do
    it "returns the id attribute if the text field exists" do
      @browser.file_field(:index, 1).id.should == "new_user_portrait"
    end

    it "raises UnknownObjectException if the text field doesn't exist" do
      lambda { @browser.file_field(:index, 1337).id }.should raise_error(UnknownObjectException)
    end
  end

  describe "#name" do
    it "returns the name attribute if the text field exists" do
      @browser.file_field(:index, 1).name.should == "new_user_portrait"
    end

    it "raises UnknownObjectException if the text field doesn't exist" do
      lambda { @browser.file_field(:index, 1337).name }.should raise_error(UnknownObjectException)
    end
  end

  describe "#title" do
    it "returns the title attribute if the text field exists" do
      @browser.file_field(:id, "new_user_portrait").title.should == "Smile!"
    end
  end

  describe "#type" do
    it "returns the type attribute if the text field exists" do
      @browser.file_field(:index, 1).type.should == "file"
    end

    it "raises UnknownObjectException if the text field doesn't exist" do
      lambda { @browser.file_field(:index, 1337).type }.should raise_error(UnknownObjectException)
    end
  end

  describe "#respond_to?" do
    it "returns true for all attribute methods" do
      @browser.file_field(:index, 1).should respond_to(:class_name)
      @browser.file_field(:index, 1).should respond_to(:id)
      @browser.file_field(:index, 1).should respond_to(:name)
      @browser.file_field(:index, 1).should respond_to(:title)
      @browser.file_field(:index, 1).should respond_to(:type)
      @browser.file_field(:index, 1).should respond_to(:value)
    end
  end

  # Manipulation methods

  describe "#set" do
    it "is able to set a file path in the field and click the upload button and fire the onchange event" do
      @browser.goto(TEST_HOST + "/forms_with_input_elements.html")
      
      alerts = []
      @browser.add_listener(:alert) { |_, msg| alerts << msg }
      @browser.file_field(:name, "new_user_portrait").set(__FILE__)
      @browser.file_field(:name, "new_user_portrait").value.should == __FILE__
      alerts.should == [__FILE__]
      @browser.button(:name, "new_user_submit").click
    end

    it "sends content as correct content type for common file types" do
      @browser.file_field(:name, "new_user_portrait").set("foo.doc")
      obj = @browser.file_field(:name, "new_user_portrait").locate
      obj.getContentType.should == "application/msword"
    end
  end

  after :all do
    @browser.close
  end

end

