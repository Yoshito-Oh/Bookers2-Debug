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
  
  attachment :profile_image, destroy: false

  validates :name, presence: true, length: {maximum: 20, minimum: 2}, uniqueness: true
  validates :introduction, length: {maximum: 50}
  #24. バリデーション追加（50文字以内）
end
