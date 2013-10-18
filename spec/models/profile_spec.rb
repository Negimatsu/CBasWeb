require 'spec_helper'

describe Profile do

  context "Database Schema" do
    it { should have_db_column(:first_name).of_type(:string) }
    it { should have_db_column(:last_name).of_type(:string) }
    it { should have_db_column(:occupation).of_type(:string) }
    it { should have_db_column(:path_file).of_type(:string) }
  end

  context "Associations" do
    it { should belong_to(:user) }
  end

  before(:each) do
    @profile = {
        :first_name => "Example",
        :last_name => "user",
        :occupation => "tester",
        :path_file => "123/"
    }
    @user = {
        :email => "user@example.com",
        :password => "changeme",
        :password_confirmation => "changeme",
    }
  end

  context "create profile" do
    it "should create a new instance given a valid attribute" do
      User.create!(@user , :profile => @profile)
    end

    it "should create first name attribute blank" do
      @profile.merge(:first_name => "")
      User.create!(@user , :profile => @profile).should be_valid
    end

    it "should create last name attribute blank" do
      @profile.merge(:last_name => "")
      User.create!(@user , :profile => @profile).should be_valid
    end

    it "should create occupation attribute blank" do
      @profile.merge(:first_name => "")
      User.create!(@user , :profile => @profile).should be_valid
    end

    it "should create path file attribute blank" do
      @profile.merge(:first_name => "")
      User.create!(@user , :profile => @profile).should be_valid
    end
  end


end
