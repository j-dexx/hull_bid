module Admin
  class ArticlesController < Manticore::ApplicationController

    helper :form
    crops_images_for Article, :image, { :show => { :fit => [440, 1000] } }

    def index
      @articles = Article.where(
        ["headline LIKE :search OR summary LIKE :search", {:search => "%#{params[:search]}%"}]
      ).order(params[:order] ||= "date DESC").page(params[:page]).per(10)
    end
    
    def new
      @article = Article.new
    end
    
    def create
      @article = Article.new(params[:article])
      if @article.save
        redirect_to admin_articles_path, :notice => "Article successfully created."
      else
        render :action => 'new'
      end
    end

    def edit
      @article = Article.find(params[:id])
    end
    
    def update
      @article = Article.find(params[:id])
      if @article.update_attributes(params[:article])
        redirect_to admin_articles_path, :notice => "Article successfully updated."
      else
        render :action => 'edit'
      end
    end
    
    def destroy
      @article = Article.find(params[:id])
      @article.destroy
      redirect_to admin_articles_path, :notice => "Article destroyed."
    end
    
  end 
end
