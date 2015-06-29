require "rails_helper"

describe CommentsController, type: :controller do
  let(:comment) { FactoryGirl.create :comment }
  let(:article) { comment.article }
  let(:current_user) { comment.owner }
  let(:valid_attributes) { { body: "Body", article_id: article.id  } }
  let(:invalid_attributes) { { body: "", article_id: article.id  } }

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
        expect(response).to redirect_to(comments_url)
      end
    end
  end

  describe "GET new" do
    let(:params) { { article_id: article.id } }

    context "not authorized current_user" do
      let(:action) { :new }
      it_should_behave_like "invalid_session_spec"
    end

    context "not authorized current_user" do
      it "assigns a new comment as @comment" do
        get :new, params
        expect(assigns(:comment)).to be_a_new(Comment)
      end
    end
  end

  describe "GET edit" do
    let(:params) { { id: comment.to_param, article_id: article.id } }

    context "not authorized current_user" do
      let(:action) { :edit }
      it_should_behave_like "invalid_session_spec"
      it_should_behave_like "invalid_current_user_spec"
    end

    context "authorized current_user" do
      it "assigns the requested comment as @comment" do
        get :edit, params
        expect(assigns(:comment)).to eq(comment)
      end
    end
  end

  describe "POST create" do
    context "not authorized current_user" do
      let(:action) { :edit }
      let(:params) { { id: comment.to_param } }
      it_should_behave_like "invalid_session_spec"
      it_should_behave_like "invalid_current_user_spec"
    end

    context "authorized current_user" do
      describe "with valid params" do
        it "creates a new Comment" do
          expect do
            post :create, comment: valid_attributes
          end.to change(Comment, :count).by(1)
        end

        it "assigns a newly created comment as @comment" do
          post :create, comment: valid_attributes
          expect(assigns(:comment)).to be_a(Comment)
          expect(assigns(:comment)).to be_persisted
          expect(assigns(:comment).owner).to eq current_user
        end

        it "redirects to the created comment" do
          post :create, comment: valid_attributes
          expect(response).to redirect_to(Comment.last)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved comment as @comment" do
          post :create, comment: invalid_attributes
          expect(assigns(:comment)).to be_a_new(Comment)
        end

        it "re-renders the 'new' template" do
          post :create, comment: invalid_attributes
          expect(response).to render_template("new")
        end
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) { { body: "NewBody", article_id: 0 } }

      it "updates the requested comment" do
        put :update, id: comment.to_param, comment: new_attributes
        comment.reload
        expect(comment.body).to eq "NewBody"
        expect(comment.article_id).to eq article.id
      end

      it "assigns the requested comment as @comment" do
        put :update, id: comment.to_param, comment: valid_attributes
        expect(assigns(:comment)).to eq(comment)
      end

      it "redirects to the comment" do
        put :update, id: comment.to_param, comment: valid_attributes
        expect(response).to redirect_to(comment)
      end
    end

    describe "with invalid params" do
      it "assigns the comment as @comment" do
        put :update, id: comment.to_param, comment: invalid_attributes
        expect(assigns(:comment)).to eq(comment)
      end

      it "re-renders the 'edit' template" do
        put :update, id: comment.to_param, comment: invalid_attributes
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested comment" do
      expect do
        delete :destroy, id: comment.to_param
      end.to change(Comment, :count).by(-1)
    end

    it "redirects to the comments list" do
      delete :destroy, id: comment.to_param
      expect(response).to redirect_to(comments_url)
    end
  end
end
