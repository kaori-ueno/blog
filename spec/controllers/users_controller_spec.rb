require "rails_helper"

describe UsersController do
  before do 
    allow_any_instance_of(ApplicationController).to receive(:authorize).and_return(true)
  end

  describe "#create" do
    it "create user" do
      param = {
        user: {
          name: "hoge",
          password: "fuga",
        }
      }
      expect { post :create, param }.to change { User.all.count }.from(0).to(1)
    end
  end

  describe "#update" do
    let!(:user) { FactoryGirl.create :user }

    it "update user" do
      post :update, {
        id: user.id,
        user: {
          name: "hoge",
          password: "fuga"
        },
      }

      expect(User.find(user.id).name).to eq "hoge"
    end
  end

  describe "#destroy" do
    let!(:user) { FactoryGirl.create :user }

    it "destroy user" do
      expect { post :destroy, { id: user.id } }.to change { User.all.count }.from(1).to(0)
    end
  end
end
