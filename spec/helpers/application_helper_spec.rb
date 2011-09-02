require 'spec_helper'

describe ApplicationHelper do
  describe "#errors_for" do
    context "when the object has no errors" do
      it "returns an empty string" do
        object = mock_model(User)
        errors_for(object).should == ""
      end
    end

    context "when the object has two errors" do
      it "returns the errors as a sentence" do
        object = Factory.build(:user, :first_name => nil, :email => nil)
        object.valid?
        errors_for(object).should == "<div class=\"alert-message error\"><p>Email can't be blank and First name can't be blank</p></div>"
      end
    end

    context "when the object has three errors" do
      it "returns the errors as a sentence" do
        object = Factory.build(:user, :first_name => nil, :email => nil, :birth_month => "January")
        object.valid?
        errors_for(object).should == "<div class=\"alert-message error\"><p>Email can't be blank, First name can't be blank, and Birth day can\'t be blank</p></div>"
      end
    end
  end

  describe "#flash_messages" do
    describe "when no flash messages are present" do
      it "returns an empty string" do
        flash_messages.should == ""
      end
    end

    describe "when a flash alert exists" do
      it "returns HTML for the message" do
        flash[:alert] = "Sorry, it will not save"
        flash_messages.should == "<div class=\"alert-message error\"><p>Sorry, it will not save</p></div>"
      end
    end

    describe "when a flash notice exists" do
      it "returns HTML for the message" do
        flash[:notice] = "You are awesome"
        flash_messages.should == "<div class=\"alert-message info\"><p>You are awesome</p></div>"
      end
    end

    describe "when both a flash notice and flash alert exist" do
      it "returns HTML for the message" do
        flash[:alert] = "Sorry, it will not save"
        flash[:notice] = "You are awesome"
        flash_messages.should == "<div class=\"alert-message info\"><p>You are awesome</p></div><div class=\"alert-message error\"><p>Sorry, it will not save</p></div>"
      end
    end
  end
end
