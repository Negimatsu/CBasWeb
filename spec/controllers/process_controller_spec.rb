require 'spec_helper'

describe ProcessController do

  before (:each) do
    @user = FactoryGirl.create(:user)
    sign_in @user
  end


  describe "GET 'finish'" do
    it "returns http success" do
      get 'finish'
      response.should be_success
    end
  end

  describe "GET 'going'" do
    it "returns http success" do
      get 'going'
      response.should be_success
    end
  end

  describe "GET 'done'" do
    it "returns http success" do
      get 'done'
      response.should be_success
    end
  end

  describe "GET 'fail'" do
    it "returns http success" do
      get 'fail'
      response.should be_success
    end
  end

end
