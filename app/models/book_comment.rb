class BookComment < ApplicationRecord
  belongs_to :user
  belongs_to :book
  #ユーザと本へ従属させる
  validates :comment, presence: true
  # コメントは0文字だとエラー
end
