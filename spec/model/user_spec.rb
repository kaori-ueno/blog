require "rails_helper"

describe "User" do
  let(:user) { FactoryGirl.create :user }

  describe "#find" do
    it "user" do
      expect { User.find user.id }.not_to raise_error
    end
  end
end
