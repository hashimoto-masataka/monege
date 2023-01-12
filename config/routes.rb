Rails.application.routes.draw do


 devise_for :admin,skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_scope :user do
   post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

 scope module: :public do
  root to: "homes#top"
  resources :users, only: [:index, :update,] do
   member do
      get :favorites
   end
  end
   get "/users/my_page" => "users#show"
   get "/users/information/edit" => "users#edit"
   patch "users/information" => "users#update"
   get "/users/unsubscribe" => "users#unsubscribe"
   patch "/users/withdraw" => "users#withdraw"
  resources :families, only: [:new,:index, :edit, :create, :update, :destroy]
  resources :categories, only: [:new,:index, :edit, :create, :update, :destroy]
  resources :incomes, only: [:new,:index, :edit, :create, :update, :destroy]
  resources :expenses, only: [:new, :index, :edit, :create, :update, :destroy]
  resources :household_accounts, only: [:new, :index, :show, :create, :destroy]do
   resource:favorites, only: [:create, :destroy]
  end

end

 namespace :admin do
  root to: "homes#top"
  resources :users, only: [:index, :show, :edit, :update]

 end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
