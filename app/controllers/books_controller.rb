class BooksController < ApplicationController

  def show
    @new_book = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
    # 22. [@user=~~~]を追記。ユーザー情報をshowメソッドにも定義した
    @book_comment = BookComment.new
    #コメントのインスタンス変数を
    @books = Book.all
  end

  def index
    @book = Book.new
    #@bookに新しい箱を用意する
    @books = Book.all
    #@booksに複数データ(全データall)を格納する
    @user = current_user
    #@userに現在ログインしているユーザー情報を格納する
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @user = @book.user
    @books = Book.all
    if @book.save
      redirect_to book_path(@book.id), notice: "You have created book successfully."
    else
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user.id != current_user.id
      redirect_to books_path
    end
  end
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render 'edit'
    end
  end

  def destroy # 23. delete ⇒ destroy
    book = Book.find(params[:id]) # @を消去
    book.destroy # destoy⇒ destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end
