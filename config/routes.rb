Rails.application.routes.draw do
  devise_for :users
  # devise_for : usersのshowページを探しに行くので、見つからないので無限に探しに行ってしまう。
  resources :users,only: [:show,:index,:edit,:update]

  resources :books do
    resource :favorites, only: [:create, :destroy]
  end

  root 'homes#top'
  get 'home/about' => 'homes#about'
end
# 1.endを追加