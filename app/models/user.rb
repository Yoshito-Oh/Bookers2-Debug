class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  # 9. 「」を「has_many :user」に変更。booksとuserの従属関係が違っている。
  #    アソシエーションに、「dependent: :destroy」を追加

  has_many :favorites, dependent: :destroy
  #いいね機能のアソシエーション

  has_many :book_comments, dependent: :destroy
  #コメント機能のアソシエーション

  # 自分がフォローしてるユーザとのアソシエーション
  has_many :active_relationships, foreign_key: "follower_id", class_name: "Relationship", dependent: :destroy
  has_many :followings, through: :active_relationships, source: :followed #follower(前)

  #自分をフォローしているユーザ(フォロワー)のアソシエーション
  has_many :passive_relationships, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower #followed(前)
  #

  def following?(other_user)
    self.followings.include?(other_user)
    #following(フォローしている人) ⇒  followed()フォローされている人
  end

  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end
  
  #ユーザの検索機能の追加-----------------------------
  def self.looks(search, word)
    if search == "perfect_match"
      @user = User.where("name LIKE ?", "#{word}")
    elsif search == "forward_match"
      @user = User.where("name LIKE ?", "#{word}%")
    elsif search == "backward_match"
      @user = User.where("name LIKE ?", "%#{word}")
    elsif search == "partial_match"
      @user = User.where("name LIKE ?", "%#{word}%")
    else
      @user = User.all
    end
  end
  #-------------------------------------------

  attachment :profile_image, destroy: false

  validates :name, presence: true, length: {maximum: 20, minimum: 2}, uniqueness: true
  validates :introduction, length: {maximum: 50}
  #24. バリデーション追加（50文字以内）
end
