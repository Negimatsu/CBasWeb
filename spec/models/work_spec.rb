require 'spec_helper'

describe Work do

  context "Database Schema" do
    it { should have_db_column(:title).of_type(:string) }
    it { should have_db_column(:description).of_type(:text) }
    it { should have_db_column(:filename).of_type(:string) }
    it { should have_db_column(:finish_date).of_type(:datetime) }
    it { should have_db_column(:status_work).of_type(:string) }
    it { should have_db_column(:is_bacteria).of_type(:boolean) }
    it { should have_db_column(:upload_date).of_type(:datetime) }
    it { should have_db_column(:pid).of_type(:string) }
  end


  context "Associations" do
    it { should belong_to(:user) }
  end

  before(:each) do
    @user = {
        :email => "user@example.com",
        :password => "changeme",
        :password_confirmation => "changeme",
    }
    @work = {
        :title => "test CBAS",
        :description => "This test",
        :filename => "filename",
        :finish_date  => DateTime.now + 1 ,
        :status_work => "processing",
        :is_bacteria => true,
        :upload_date => DateTime.now,
        :pid => "1234"
    }
    @user = User.create!(@user)
  end

  context "creat new work" do
    it "should create a new instance given a valid attribute" do
      @user.works.new(@work)
    end

    it "should reject not have title" do
      @work.merge(:title => "")
      @user.works.new(@work).should_not be_valid

    end

    it "should reject not have filename" do
      @work.merge(:filename => "")
      @user.works.new(@work).should_not be_valid
    end

    it "should reject not select is bacteria" do
      @work.merge(:is_bacteria => "")
      @user.works.new(@work).should_not be_valid
    end
  end

end
