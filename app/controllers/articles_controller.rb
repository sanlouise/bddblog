class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end
  
  def new
    @article = Article.new
  end
  
  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:success] = "Your article was created successfully!"
      redirect_to articles_path
    else 
      flash.now[:danger] = "Your article was not created!"
      render :new
    end
  end
  
  def edit
    @article = Article.find(params[:id])
  end
  
  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      flash[:success] = "Article was updated successfully."
      redirect_to @article
    else
      flash.now[:danger] = "Oops, something went wrong. Article could not be updated."
      render :edit
    end
  end
  
  
  def show
    @article = Article.find(params[:id])
  end
  
  
  private
    def article_params
      params.require(:article).permit(:title, :body)
    end
  
    
end
