class FavoritesController < ApplicationController
  before_action :ensure_correct_user, only: [:favorites]

  def favorites
    @user = User.find(params[:user_id])
    @books = @user.favorites
  end

  def create
    @book = Book.find(params[:book_id])
    favorite = current_user.favorites.new(book_id: @book.id)
    favorite.save
    # redirect_to request.referer
  end

  def destroy
    @book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: @book.id)
    favorite.destroy
    # redirect_to request.referer
  end

  private

  def ensure_correct_user
    @user = User.find(params[:user_id])
    if @user.id != current_user.id
      redirect_to user_path(current_user.id), notice: " 「いいねした本一覧」画面は本人以外閲覧できません"
    end
  end
end
