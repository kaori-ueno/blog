class ArticlesController < ApplicationController
  before_action :authorize, only: %i(new edit create update destroy)
  before_action :set_article, only: %i(show edit update destroy)
  before_action :validate_user, only: %i(edit update destroy)

  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.all
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params_for_create)
    # TODO ここキモいからエラーハンドリングでどうにかする
    return if validate_user

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params_for_update)
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    def validate_user
      redirect_to articles_url, notice: "The article is not yours." unless @article.is_owner? current_user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params_for_create
      params.require(:article).permit(:title, :body, :blog_id)
    end

    def article_params_for_update
      params.require(:article).permit(:title, :body)
    end
end
