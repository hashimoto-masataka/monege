Rails.application.routes.draw do


 devise_for :admin,skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

 scope module: :public do
  root to: "homes#top"
  resources :users, only: [:index, :update,]
   get "/users/my_page" => "users#show"
   get "/users/information/edit" => "users#edit"
   patch "users/information" => "users#update"
   get "/users/unsubscribe" => "users#unsubscribe"
   patch "/users/withdraw" => "users#withdraw"
  resources :families, only: [:new,:index, :edit, :create, :update, :destroy]
  resources :categories, only: [:new,:index, :edit, :create, :update, :destroy]
  resources :incomes, only: [:new,:index, :edit, :create, :update, :destroy]
  resources :expenses, only: [:new, :index, :edit, :create, :update, :destroy]
  resources :household_accounts, only: [:new, :index, :show, :create, :destroy]

end

 namespace :admin do
  root to: "homes#top"
  resources :users, only: [:index, :show, :edit, :update]

 end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
