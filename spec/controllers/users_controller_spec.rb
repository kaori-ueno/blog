require "rails_helper"

describe UsersController, type: :controller do
  let(:valid_attributes) { { name: "hoge", password: "fuga" } }
  let(:user) { FactoryGirl.create :user }
  let(:current_user) { user }

  before do 
    allow_any_instance_of(SessionsHelper).to receive(:current_user).and_return(current_user)
  end

  shared_examples_for "invalid_session_spec" do
    describe "invalid sessions" do
      let(:current_user) { nil }
      it "redirects to the session" do 
        get action, params
        expect(response).to redirect_to(controller: "sessions", action: "new")
      end
    end
  end

  shared_examples_for "invalid_current_user_spec" do
    describe "invalid current_user" do
      let(:current_user) { FactoryGirl.create :user }
      it "redirect to the article" do
        get action, params
        expect(response).to redirect_to(users_url)
      end
    end
  end

  describe "GET edit" do
    describe "current_user is not authorized" do
      let(:action) { :edit }
      let(:params) { { id: user.to_param } }
      it_should_behave_like "invalid_session_spec"
      it_should_behave_like "invalid_current_user_spec"
    end

    describe "current_user is authorized" do
      it "assigns the requested article as @user" do
        get :edit, {:id => user.to_param}
        expect(assigns(:user)).to eq user
      end
    end
  end

  describe "POST create" do
    it "create user" do
      expect { post :create, { user: valid_attributes } }.to change(User, :count).by(1)
    end
  end

  describe "POST update" do
    describe "current_user is not authorized" do
      let(:action) { :update }
      let(:params) { { id: user.id, user: valid_attributes } }
      it_should_behave_like "invalid_session_spec"
      it_should_behave_like "invalid_current_user_spec"
    end

    describe "current_user is authorized" do
      it "update user" do
        post :update, { id: user.id, user: valid_attributes }
        expect(User.find(user.id).name).to eq "hoge"
      end
    end
  end

  describe "DELETE destroy" do
    describe "current_user is not authorized" do
      let(:action) { :destroy }
      let(:params) { { id: user.id } }
      it_should_behave_like "invalid_session_spec"
      it_should_behave_like "invalid_current_user_spec"
    end

    describe "current_user is authorized" do
      it "destroy user" do
        expect { post :destroy, { id: user.to_param } }.to change(User, :count).by(-1)
        expect(response).to redirect_to(users_url)
      end
    end
  end
end
