class CommentsController < ApplicationController
  
  def create
    @comment = @article.comments.build(comment_params)
    @comment.user = current_user
    
    if @comment.save 
      flash[:success] = "Your comment was added successfully."
    else
      flash[:danger] = "Oops.. something went wrong. Your comment was not added."
    end
      redirect_to article_path(@article)
  end
  
  private
    def comment_params
      params.require(:comment).permit(@article)
    end
    
    def set_article
      @article = Article.find(params[:article_id])
    end
  
end
