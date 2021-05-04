class Book < ApplicationRecord
	belongs_to :user
	# 9.has_many :userを「belongs_to :user」に変更。booksとuserの従属関係が違っている。
	
	has_many :favorites, dependent: :destroy
	#いいね機能のアソシエーション
	
	has_many :book_comments, dependent: :destroy
	#コメント機能のアソシエーション
	
	def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	end

	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}
end
