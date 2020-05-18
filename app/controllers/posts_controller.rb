class PostsController < ApplicationController
  before_action :authenticate_user
  before_action :ensure_correct_user, {only: [:edit, :update, :destroy]}
  
  
  def index
    @posts=Post.all.order(created_at: :desc)
    
  end
  
  def create
    @post=Post.new(item: params[:item], 
                  work: params[:work], 
                  report: params[:report],
                  user_id: @current_user.id)
    @post.save
   
    @media=Medium.new(media_name: params[:media],
                      post_id: @post.id)
    @media.save
    redirect_to("/posts/index")
    flash[:notice]="レポートを記録しました"
  end

  def show
    @post=Post.find_by(id: params[:id])
    @media=Medium.find_by(post_id: params[:id])
  end
  
  def edit
    @post=Post.find_by(id: params[:id])
  end
  
  def update
    @post=Post.find_by(id: params[:id])
    @post.item=params[:item]
    @post.work=params[:work]
    @post.report=params[:report]
    @post.save
    @media=Medium.find_by(post_id: @post.id)
    @media.media_name=params[:media_name]
    if @media
      @media.save
    end
    redirect_to("/posts/index")
    flash[:notice]="レポートを編集しました"
  end
  
  def destroy
    @media=Medium.find_by(post_id: params[:id])
    if @media
     @media.destroy
    end
    @post=Post.find_by(id: params[:id])
    @post.destroy
    redirect_to("/posts/index")

    flash[:notice]="レポートを削除しました"

  end

  def ensure_correct_user
    @post = Post.find_by(id: params[:id])
    if @post.user_id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end
  end

end
