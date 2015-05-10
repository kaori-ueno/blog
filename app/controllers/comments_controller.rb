class CommentsController < ApplicationController
  before_action :authorize, only: %i(new edit create update destroy)
  before_action :set_comment, only: %i(show new edit create update destroy)
  before_action :validate_user, only: %i(edit update destroy)

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment, notice: "Comment was successfully created." }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new, article_id: @comment.article }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params_for_update)
        format.html { redirect_to @comment, notice: "Comment was successfully updated." }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_url, notice: "Comment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_comment
    @comment = case params[:action]
               when "new"
                 article = Article.find params[:article_id]
                 Comment.new article_id: article.id
               when "create"
                 Comment.new comment_params_for_create
               else
                 Comment.find(params[:id])
               end
  end

  def validate_user
    redirect_to comments_url, notice: "The comment is not yours." unless @comment.owner? current_user
  end

  def comment_params_for_create
    params[:comment][:user_id] = current_user.id
    params.require(:comment).permit(:body, :user_id, :article_id)
  end

  def comment_params_for_update
    params.require(:comment).permit(:body)
  end
end
