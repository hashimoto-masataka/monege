Rails.application.routes.draw do

 scope module: :public do

  resources :customers, only: [:index, :update,]
   get "/customers/my_page" => "customers#show"
   get "/customers/information/edit" => "customers#edit"
   patch "customers/information" => "customers#update"
   get "/customers/unsubscribe" => "customers#unsubscribe"
   patch "/customers/withdraw" => "customers#withdraw"
  resources :families, only: [:new,:index, :edit, :create, :update, :destroy]
  resources :categories, only: [:new,:index, :edit, :create, :update, :destroy]
  resources :incomes, only: [:new,:index, :edit, :create, :update, :destroy]
  resources :expenses, only: [:new, :index, :edit, :create, :update, :destroy]
  resources :household_accounts, only: [:new, :index, :edit, :show, :create, :update, :destroy]

end

  devise_for :admin,skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  scope module: :public do
  root to: "homes#top"
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
