class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show, :destroy]
  before_action :require_user, only: [:edit, :update, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Welcome to the Alpha Blog #{@user.username}, you have successfully signed in."
      redirect_to articles_path
    else
      render 'new'
    end
  end

  def edit
    
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "User account was update successfully!"
      redirect_to @user
    else
      render 'edit'
    end
    
  end

  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 2)
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 2)
  end
  
  def destroy
    @user.destroy
    session[:user_id] = nil
    flash[:notice] = "Account and all associeate articles successfully deleted"
    redirect_to articles_path
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if @user != current_user
      flash[:alert] = "You can only edit your onw account"
      redirect_to @user
    end
  end
  
  
end