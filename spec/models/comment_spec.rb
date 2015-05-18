require "rails_helper"

describe Comment, type: :model do
  let(:comment) { FactoryGirl.create :comment }

  describe "#owner?" do
    context "user is owner" do
      it "returns true" do
        expect(comment.owner?(comment.owner)).to eq true
      end
    end

    context "user is owner" do
      let(:user) { FactoryGirl.create :user }
      it "returns true" do
        expect(comment.owner?(user)).to eq false
      end
    end
  end
end
