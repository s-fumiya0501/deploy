class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @users = User.all
    @book = Book.new
    @user = current_user
  end


  def show
    @book = Book.new
    @user = User.find(params[:id])
    @books = @user.books.page(params[:page]).reverse_order
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id),notice: 'You have created book successfully.'
    else
      @books = Book.all
      @user = current_user
      render :index
    end
  end

  def edit
    @user = User.find(params[:id])
    if @user.id!=current_user.id
      redirect_to user_path(current_user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id),notice:"You have updated user successfully."
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image,:introduction)
  end

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
