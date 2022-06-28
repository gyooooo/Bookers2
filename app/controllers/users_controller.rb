class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @users = User.all
    @user =  current_user
    @book = Book.new
  end

  def show
    @user = User.find(params[:id])
    @new_book = Book.new
    @books = @user.books
  end

  def edit
     @user = User.find(params[:id])
     if @user == current_user
    # @users =  current_user
    # @book = current_user
    render "edit"
     else
       redirect_to user_path(current_user.id)
     end
  end
  
  def login
    @user = User.find_by(email: params[:name], password: params[:password])
    if @user.signup
      flash[:notice] = "Welcome! You have signed up successfully."
      redirect_to("/posts/index")
    else
      render("users/login_form")
    end
  end
  
  def logout
    @user = User.find_by(email: params[:name], password: params[:password])
    if @user.signout
      flash[:notice] = "Signed out successfully."
      redirect_to user_path
    else
      render :index
    end
  end
  
   def destroy
     @book = Book.find(params[:id])
     if @book.destroy
     flash[:notice] = "Book was successfully destroyed."
     redirect_to user_path
     else
    @books = Book.all
    render :index
     end
   end
  
   def update
    # @user = User.find(params[:id])
    @user = current_user
    if @user.update(user_params)
    flash[:notice] = "You have updated user successfully.."
    redirect_to user_path(@user.id)
    else
    render :edit
    end
   end
   
   def create
    user = User.new(user_params)
    user.save
    if @book.save
    flash[:success] = "You have created book successfully."
    redirect_to book_path(id: current_user)
    else
    flash.now[:alert] = "You have created book error."
    render :index
    end
    # redirect_to user_path(id: current_user)
   end
   
  
  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
  
  def correct_user
    @user = User.find(params[:id])
    @user = @user.new
    redirect_to(users_path) unless @user == current_user
  end
end