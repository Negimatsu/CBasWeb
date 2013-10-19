require 'spec_helper'

describe WorkController do

  context "Signed in" do

    before (:each) do
      @user = FactoryGirl.create(:user)

      sign_in @user
    end

    describe "GET 'new'" do
      it "returns http success" do
        get 'new'
        response.should be_success
      end
    end

    describe "POST 'create'" do
      it "returns http success" do
        post 'create'
        response.should be_success
      end
    end

  end

  context "Not signed in" do
    before (:each) do
      @user = FactoryGirl.create(:user)
    end

    describe "GET 'new'" do
      it "returns http success" do
        get 'new'
        response.should redirect_to(new_user_session_path)
      end
    end

    describe "POST 'create'" do
      it "returns http success" do
        post 'create'
        response.should redirect_to(new_user_session_path)
      end
    end
  end

end
