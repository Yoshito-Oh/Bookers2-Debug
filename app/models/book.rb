class Book < ApplicationRecord
	belongs_to :user
	# 9.has_many :userを「belongs_to :user」に変更。booksとuserの従属関係が違っている。

	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}
end
