Rcheckin::Application.routes.draw do
  root :to => 'home#index'

  match "/signin"                  => "authentications#new"
  match "/auth/:provider/callback" => "authentications#create"

  resources :users, :only => [ :index, :show, :new ] do
    resource :condition, :only => [ :show, :update ]
  end
end
