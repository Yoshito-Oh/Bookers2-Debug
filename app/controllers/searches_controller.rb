class SearchesController < ApplicationController
  before_action :authenticate_user!
  
  def search
    @range = params[:range] #@range(範囲)を定義
   
    @word = params[:word]
    if @range == "User" #Userが選ばれたなら
      @user = User.looks(params[:search],params[:word])
      #user内の「search(一致内容)」「word(検索ワード)」の引数から
      #ユーザー情報を@userに格納する
    else #ユーザではなく本から検索する場合
      @book = Book.looks(params[:search],params[:word])
    end
  end
end
