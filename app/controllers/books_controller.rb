class BooksController < ApplicationController
  # before_action :correct_user, only: [:edit, :update, :destroy,]
  
   def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
    flash[:notice] = "You have created book successfully."
    redirect_to book_path(@book.id)
    else
    flash.now[:alert] = "You have created book error."
    @books = Book.all
    @users = User.all
    @user = current_user
    render :index
    end
   end

  def index
    @books = Book.all
    @users = User.all
    @book = Book.new
    @user = current_user
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @books = Book.new
  end
  
  
  def edit
  @book = Book.find(params[:id])
  if @book.user == current_user
  render "edit"
  else
  redirect_to books_path
  end
  end

  
  def destroy
     @book = Book.find(params[:id])
     if @book.destroy
     flash[:notice] = "Book was successfully destroyed."
     redirect_to books_path
     else
    @books = Book.all
    render :index
     end
  end
  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
    flash[:notice] = "Book was successfully updated."
    redirect_to book_path(@book.id)
    else
    render :edit
    end
  end
  
  
  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
  def user_params
    params.require(:book).permit(:name, :profile_image)
  end
end

  def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    redirect_to(books_path) unless @user == current_user
  end
  
  def new
    @post_image = PostImage.new
  end
  
  