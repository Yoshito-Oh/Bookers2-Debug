Rails.application.routes.draw do
  get 'searches/search'
  devise_for :users
  # devise_for : usersのshowページを探しに行くので、見つからないので無限に探しに行ってしまう。
  resources :users,only: [:show,:index,:edit,:update]

  resources :books do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
    #resource(単数形)  , :[モデル](複数形)
  end
  
  resources :users, only: [:show, :index, :edit, :update] do
    member do
      get :following, :followers
    end
    resource :relationships, only: [:create, :destroy]
  end
  
  root 'homes#top'
  get 'home/about' => 'homes#about'
end
# 1.endを追加