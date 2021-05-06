class RelationshipsController < ApplicationController

   before_action :authenticate_user!
   #ログイン済みユーザーにのみアクセスを許可する

  def create
    follow = current_user.active_relationships.build(followed_id: params[:user_id])
    follow.save
    #現在のユーザと指定のユーザーをidをフォローする
    redirect_to request.referer
  end

  def destroy
    follow = current_user.active_relationships.find_by(followed_id: params[:user_id])
    follow.destroy
    #以下、全ユーザのフォローフォロワーを0にするコード
    #users = User.all
    #users.each do |user|
    #  user.active_relationships.destroy_all
    #  user.passive_relationships.destroy_all
    #end
    redirect_to request.referer
  end
end

#参考記事
#  https://junblog11.com/ruby-on-rails%E3%81%A7%E3%83%95%E3%82%A9%E3%83%AD%E3%83%BC%E6%A9%9F%E8%83%BD%E3%82%92%E3%81%A4%E3%81%91%E3%82%8B/