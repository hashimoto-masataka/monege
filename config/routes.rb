Rails.application.routes.draw do


  namespace :public do
    get 'relationships/followings'
    get 'relationships/followers'
  end
 devise_for :admin,skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  devise_for :users, controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_scope :user do
   post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

 scope module: :public do
  root to: "homes#top"
  get 'homes/about' => 'homes#about'
  resources :users, only: [:index, :update,] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' =>'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
   end

   get "/users/my_page" => "users#show"
   get "/users/information/edit" => "users#edit"
   patch "users/information" => "users#update"
   get '/users/:id/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
  # 論理削除用のルーティング
  patch '/users/:id/withdraw' => 'users#withdraw', as: 'withdraw'
  resources :families, only: [:new,:index, :edit, :create, :update, :destroy]
  resources :categories, only: [:new, :show, :index, :edit, :create, :update, :destroy]
  resources :incomes, only: [:new,:index, :edit, :create, :update, :destroy]
  resources :expenses, only: [:new, :index, :edit, :create, :update, :destroy]



end

 namespace :admin do
  root to: "homes#top"
  resources :users, only: [:index, :show, :edit, :update]
    get '/users/:id/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
  # 論理削除用のルーティング
    patch '/users/:id/withdraw' => 'users#withdraw', as: 'withdraw'

 end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
