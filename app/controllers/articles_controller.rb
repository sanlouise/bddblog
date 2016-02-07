class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_article, only: [:edit, :update, :show, :destroy]
  
  def index
    @articles = Article.all
  end
  
  def new
    @article = Article.new
  end
  
  def create
    @article = current_user.articles.build(article_params)
    if @article.save
      flash[:success] = "Your article was created successfully!"
      redirect_to articles_path
    else 
      flash.now[:danger] = "Your article was not created!"
      render :new
    end
  end
  
  def edit
    if @article.user != current_user
      flash[:danger] = "You can only edit your own articles."
      redirect_to root_path
    end
  end
  
  def update
    if @article.user != current_user
      flash[:danger] = "You can only edit your own articles."
      redirect_to root_path
    elsif @article.update(article_params)
        flash[:success] = "Article was updated successfully."
        redirect_to @article
    else
      flash.now[:danger] = "Oops, something went wrong. Article could not be updated."
      render :edit
    end
  end
  
  def show
  end
  
  def destroy
    if @article.destroy
      flash[:success] = "Your article was deleted successfully."
      redirect_to articles_path
    end
  end
  
  
  
  private
    def article_params
      params.require(:article).permit(:title, :body)
    end
  
    def set_article
      @article = Article.find(params[:id])
    end
end
