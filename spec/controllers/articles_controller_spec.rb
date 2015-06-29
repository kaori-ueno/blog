require 'rails_helper'

describe ArticlesController, :type => :controller do
  let!(:article) { Article.create! valid_attributes }
  let(:blog) { FactoryGirl.create :blog, user_id: user.id }
  let(:user) { FactoryGirl.create :user }
  let(:current_user) { user }
  let(:valid_attributes) { { title: "Title", body: "Body", blog_id: blog.id } }
  let(:invalid_attributes) { { title: "Title", body: "", blog_id: blog.id } }

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
        expect(response).to redirect_to(articles_url)
      end
    end
  end

  describe "GET show" do
    it "assigns the requested article as @article" do
      get :show, {:id => article.to_param}
      expect(assigns(:article)).to eq article
    end
  end

  describe "GET new" do
    it "assigns a new article as @article" do
      get :new, {}
      expect(assigns(:article)).to be_a_new Article
    end
  end

  describe "GET edit" do
    describe "not authorized current_user" do
      let(:action) { :edit }
      let(:params) { { id: article.to_param } }
      it_should_behave_like "invalid_session_spec"
      it_should_behave_like "invalid_current_user_spec"
    end

    describe "authorized current_user" do
      it "assigns the requested article as @article" do
        get :edit, {:id => article.to_param}
        expect(assigns(:article)).to eq article
      end
    end
  end

  describe "POST create" do
    describe "not authorized current_user" do
      let(:action) { :create }
      let(:params) { { article: valid_attributes } }
      it_should_behave_like "invalid_session_spec"
    end

    describe "authorized current_user" do
      describe "with valid params" do
        it "creates a new Article" do
          expected = expect do
            post :create, {:article => valid_attributes}
          end
          expected.to change(Article, :count).by(1)
        end

        it "assigns a newly created article as @article" do
          post :create, {:article => valid_attributes}
          expect(assigns(:article)).to be_a(Article)
          expect(assigns(:article)).to be_persisted
        end

        it "redirects to the created article" do
          post :create, {:article => valid_attributes}
          expect(response).to redirect_to(Article.last)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved article as @article" do
          post :create, {:article => invalid_attributes}
          expect(assigns(:article)).to be_a_new(Article)
        end

        it "re-renders the 'new' template" do
          post :create, {:article => invalid_attributes}
          expect(response).to render_template("new")
        end
      end
    end
  end

  describe "PUT update" do
    let(:new_attributes) { { title: "New Title", body: "New Body" } }

    describe "not authorized current_user" do
      let(:action) { :update }
      let(:params) { { id: article.to_param, article: new_attributes } }
      it_should_behave_like "invalid_session_spec"
      it_should_behave_like "invalid_current_user_spec"
    end

    describe "authorized current_user" do
      describe "with valid params" do
        it "updates the requested article" do
          put :update, {:id => article.to_param, :article => new_attributes}
          article.reload
          %i(title body).each do |key|
            expect(article.send(key)).to eq new_attributes[key]
          end
        end

        it "assigns the requested article as @article" do
          put :update, {:id => article.to_param, :article => valid_attributes}
          expect(assigns(:article)).to eq(article)
        end

        it "redirects to the article" do
          put :update, {:id => article.to_param, :article => valid_attributes}
          expect(response).to redirect_to(article)
        end
      end

      describe "with invalid params" do
        it "assigns the article as @article" do
          put :update, {:id => article.to_param, :article => invalid_attributes}
          expect(assigns(:article)).to eq(article)
        end

        it "re-renders the 'edit' template" do
          put :update, {:id => article.to_param, :article => invalid_attributes}
          expect(response).to render_template("edit")
        end
      end
    end
  end

  describe "DELETE destroy" do
    describe "not authorized current_user" do
      let(:action) { :destroy }
      let(:params) { { id: article.to_param } }
      it_should_behave_like "invalid_session_spec"
      it_should_behave_like "invalid_current_user_spec"
    end

    describe "authorized current_user" do
      it "destroys the requested article" do
        expected = expect do
          delete :destroy, {:id => article.to_param}
        end
        expected.to change(Article, :count).by(-1)
      end

      it "redirects to the articles list" do
        delete :destroy, {:id => article.to_param}
        expect(response).to redirect_to(articles_url)
      end
    end
  end
end
