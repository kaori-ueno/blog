require 'rails_helper'

describe ArticlesController, :type => :controller do
  let(:valid_attributes) { { title: "Title", body: "Body" } }
  let(:invalid_attributes) { { title: "Title", body: "" } }
  let(:valid_session) { {} }

  describe "GET index" do
    let!(:article) { FactoryGirl.create :article }

    it "assigns all articles as @articles" do
      get :index, {}, valid_session
      expect(assigns(:articles)).to eq [article]
    end
  end

  describe "GET show" do
    let!(:article) { FactoryGirl.create :article }

    it "assigns the requested article as @article" do
      get :show, {:id => article.to_param}, valid_session
      expect(assigns(:article)).to eq article
    end
  end

  describe "GET new" do
    it "assigns a new article as @article" do
      get :new, {}, valid_session
      expect(assigns(:article)).to be_a_new Article
    end
  end

  describe "GET edit" do
    it "assigns the requested article as @article" do
      article = Article.create! valid_attributes
      get :edit, {:id => article.to_param}, valid_session
      expect(assigns(:article)).to eq article
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Article" do
        expected = expect do
          post :create, {:article => valid_attributes}, valid_session
        end
        expected.to change(Article, :count).by(1)
      end

      it "assigns a newly created article as @article" do
        post :create, {:article => valid_attributes}, valid_session
        expect(assigns(:article)).to be_a(Article)
        expect(assigns(:article)).to be_persisted
      end

      it "redirects to the created article" do
        post :create, {:article => valid_attributes}, valid_session
        expect(response).to redirect_to(Article.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved article as @article" do
        post :create, {:article => invalid_attributes}, valid_session
        expect(assigns(:article)).to be_a_new(Article)
      end

      it "re-renders the 'new' template" do
        post :create, {:article => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    let(:article) { Article.create! valid_attributes }

    describe "with valid params" do
      let(:new_attributes) { { title: "New Title", body: "New Body" } }

      it "updates the requested article" do
        put :update, {:id => article.to_param, :article => new_attributes}, valid_session
        article.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested article as @article" do
        put :update, {:id => article.to_param, :article => valid_attributes}, valid_session
        expect(assigns(:article)).to eq(article)
      end

      it "redirects to the article" do
        put :update, {:id => article.to_param, :article => valid_attributes}, valid_session
        expect(response).to redirect_to(article)
      end
    end

    describe "with invalid params" do
      it "assigns the article as @article" do
        put :update, {:id => article.to_param, :article => invalid_attributes}, valid_session
        expect(assigns(:article)).to eq(article)
      end

      it "re-renders the 'edit' template" do
        put :update, {:id => article.to_param, :article => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    let(:article) { Article.create! valid_attributes }

    it "destroys the requested article" do
      expect {
        delete :destroy, {:id => article.to_param}, valid_session
      }.to change(Article, :count).by(-1)
    end

    it "redirects to the articles list" do
      delete :destroy, {:id => article.to_param}, valid_session
      expect(response).to redirect_to(articles_url)
    end
  end

end
