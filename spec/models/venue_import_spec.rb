# encoding: utf-8

require 'spec_helper'

describe VenueImport do
  subject { VenueImport.new(file: file) }
  let(:file) { double(:close => true) }

  it { should_not be_persisted }

  context "after a save" do
    let(:saved) { [] }
    let(:unsaved) { [] }

    before do
      subject.stub(:saved_venues).and_return(saved)
      subject.stub(:unsaved_venues).and_return(unsaved)
    end

    context "when all venues are successfully imported" do
      let(:saved) { [mock] }
      its(:report) { should == "1 venue(s) were successfully imported." }
    end

    context "when some did not work" do
      let(:unsaved) { [mock] }
      its(:report) { should == "0 venue(s) were successfully imported. 1 venue(s) could not be imported." }
    end
  end

  context "with an invalid CSV file" do
    let(:file) { ActionDispatch::Http::UploadedFile.new(:tempfile => File.new(Rails.root.join('spec', 'test_files', 'venues_with_encoding_issue.csv'))) }
    before { subject.save }

    it { should_not be_valid }
    its("errors.full_messages") { should include('Csv file is not valid') }
  end

  context "with a valid CSV file containing a single venue" do
    let(:file) { ActionDispatch::Http::UploadedFile.new(:tempfile => File.new(Rails.root.join('spec', 'test_files', 'valid_venue.csv'))) }

    it { should be_valid }
    its(:file) { should == file }

    context "when the related category exists" do
      let!(:category) { Factory.create(:venue_category, name: "Restaurant") }
      let!(:venue_import) { VenueImport.new(file: file) }

      subject {  venue_import.save; Venue.find_by_name("`inoteca") }

      it "should have a saved venue" do
        venue_import.save
        venue_import.should have(1).saved_venues
      end

      it { should be_persisted }
      its(:venue_category) { should == category }
      its(:address1) { should == "98 Rivington St" }
      its(:address2) { should == "Suite B" }
      its(:city) { should == "New York" }
      its(:state) { should == "NY" }
      its(:zip) { should == "10002" }
      its(:phone) { should == "2126140473" }
      its(:url) { should == "http://www.inotecanyc.com" }

      context "when the related subcategory exists" do
        let!(:subcategory) { Factory.create(:venue_subcategory, name: "Italian", venue_category: category) }
        its(:venue_subcategory) { should == subcategory }
        it { should be_persisted }
      end

      context "when the related subcategory does not exist" do
        its(:venue_subcategory) { should_not be }
        it { should be_persisted }
      end
    end

    context "when no categories exist" do
      before { subject.save }
      it { should have(1).unsaved_venues }
    end
  end
end
