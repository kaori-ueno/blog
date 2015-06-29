require 'rails_helper'

describe BlogsController, :type => :controller do
  let!(:blog) { FactoryGirl.create :blog, user_id: user.id }
  let(:user) { FactoryGirl.create :user }
  let(:current_user) { user }
  let(:valid_attributes) { { name: "Blog"} }
  let(:invalid_attributes) { { name: ""  } }

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
        expect(response).to redirect_to(blogs_url)
      end
    end
  end

  describe "GET show" do
    it "assigns the requested blog as @blog" do
      get :show, {:id => blog.to_param}
      expect(assigns(:blog)).to eq(blog)
    end
  end

  describe "GET new" do
    context "current_user is not authorized" do
      let(:action) { :create }
      let(:params) { { blog: valid_attributes } }
      it_should_behave_like "invalid_session_spec"
    end

    context "current_user is authorized" do
      it "assigns a new blog as @blog" do
        get :new, {}
        expect(assigns(:blog)).to be_a_new(Blog)
      end
    end
  end

  describe "GET edit" do
    context "current_user is not authorized" do
      let(:action) { :edit }
      let(:params) { { id: blog.to_param } }
      it_should_behave_like "invalid_session_spec"
      it_should_behave_like "invalid_current_user_spec"
    end


    context "current_user is not authorized" do
      it "assigns the requested blog as @blog" do
        get :edit, {:id => blog.to_param}
        expect(assigns(:blog)).to eq(blog)
      end
    end
  end

  describe "POST create" do
    context "current_user is not authorized" do
      let(:action) { :create }
      let(:params) { { blog: valid_attributes } }
      it_should_behave_like "invalid_session_spec"
    end

    context "current_user is authorized" do
      context "with valid params" do
        it "creates a new Blog" do
          expect {
            post :create, {:blog => valid_attributes}
          }.to change(Blog, :count).by(1)
        end

        it "assigns a newly created blog as @blog" do
          post :create, {:blog => valid_attributes}
          expect(assigns(:blog)).to be_a(Blog)
          expect(assigns(:blog)).to be_persisted
        end

        it "redirects to the created blog" do
          post :create, {:blog => valid_attributes}
          expect(response).to redirect_to(Blog.last)
        end
      end

      context "with invalid params" do
        it "assigns a newly created but unsaved blog as @blog" do
          post :create, {:blog => invalid_attributes}
          expect(assigns(:blog)).to be_a_new(Blog)
        end

        it "re-renders the 'new' template" do
          post :create, {:blog => invalid_attributes}
          expect(response).to render_template("new")
        end
      end
    end
  end

  describe "PUT update" do
    context "current_user is not authorized" do
      let(:action) { :update }
      let(:params) { { id: blog.to_param, blog: valid_attributes } }
      it_should_behave_like "invalid_session_spec"
      it_should_behave_like "invalid_current_user_spec"
    end

    context "current_user is authorized" do
      context "with valid params" do
        it "updates the requested blog" do
          put :update, {:id => blog.to_param, :blog => valid_attributes}
          blog.reload
          valid_attributes.keys.each do |key|
            expect(blog.send(key)).to eq valid_attributes[key]
          end
        end

        it "assigns the requested blog as @blog" do
          put :update, {:id => blog.to_param, :blog => valid_attributes}
          expect(assigns(:blog)).to eq(blog)
        end

        it "redirects to the blog" do
          put :update, {:id => blog.to_param, :blog => valid_attributes}
          expect(response).to redirect_to(blog)
        end
      end

      context "with invalid params" do
        it "assigns the blog as @blog" do
          put :update, {:id => blog.to_param, :blog => invalid_attributes}
          expect(assigns(:blog)).to eq(blog)
        end

        it "re-renders the 'edit' template" do
          put :update, {:id => blog.to_param, :blog => invalid_attributes}
          expect(response).to render_template("edit")
        end
      end
    end
  end

  describe "DELETE destroy" do
    context "current_user is not authorized" do
      let(:action) { :destroy }
      let(:params) { { id: blog.to_param } }
      it_should_behave_like "invalid_session_spec"
      it_should_behave_like "invalid_current_user_spec"
    end

    context "current_user is authorized" do
      it "destroys the requested blog" do
        expect {
          delete :destroy, {:id => blog.to_param}
        }.to change(Blog, :count).by(-1)
      end

      it "redirects to the blogs list" do
        delete :destroy, {:id => blog.to_param}
        expect(response).to redirect_to(blogs_url)
      end
    end
  end
end
