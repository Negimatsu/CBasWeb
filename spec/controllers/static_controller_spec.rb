require 'spec_helper'

describe StaticController do

  describe "GET each page" do

    it "can goto document page" do
      get :document
      response.should be_success
    end

    it "can goto contact page" do
      get :contact
      response.should be_success
    end
  end

end
