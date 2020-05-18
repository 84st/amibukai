class UsersController < ApplicationController
  before_action :authenticate_user, {only: [:index, :show, :edit, :update]}
  before_action :forbid_login_user, {only: [:new, :create, :login_form, :login]}
  before_action :ensure_correct_user, {only: [:edit, :update]}
  
  
  def index
  end

  
  def new
  end

  def show
    @user=User.find_by(id:params[:id])
    
  end
  
  
  def create
    @user=User.new(name:params[:name], 
    email:params[:email], 
    password:params[:password],
    prefecture:params[:prefecture],
    area:params[:area],
    cultivation_area:params[:cultivation_area]
    )
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "アカウントを作成しました"
      redirect_to("/users/#{@user.id}")
    else
      render("users/new")
    end

    
    
  end
  
  def edit
    @user=User.find_by(id:params[:id])
  end
  
  def update
    @user=User.find_by(id:params[:id])
    
    @user.name=params[:name]
    @user.email=params[:email]
    @user.password=params[:password]
    @user.prefecture=params[:prefecture]
    @user.area=params[:area]
    @user.cultivation_area=params[:cultivation_area]
    
    @user.save

    
    
    redirect_to("/users/#{@user.id}")
    
    flash[:notice]="アカウントを編集しました"

  end

  def login_form
  end
  
  def login
    @user=User.find_by(email:params[:email], password:params[:password])
    if @user
      session[:user_id]=@user.id
      flash[:notice]="ログインに成功しました"
      redirect_to("/posts/index")
    else
      render("users/login_form")
      flash[:notice]="メースアドレスかパスワードが間違っています"
    end
  end

  def logout
    session[:user_id]= nil
    flash[:notice]="ログアウトしました"
    redirect_to("/login_form")
  end

  def ensure_correct_user
    if @current_user.id != params[:id].to_i
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end
  end

  
end
