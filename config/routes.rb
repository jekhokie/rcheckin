Rcheckin::Application.routes.draw do
  root :to => 'home#index'

  match "/signin"                  => "authentications#new"
  match "/signout"                 => "authentications#signout"
  match "/auth/:provider/callback" => "authentications#create"

  resources :users, :only => [ :create, :index, :show, :new ] do
    resource :condition, :only => [ :show, :update ]
  end
end
