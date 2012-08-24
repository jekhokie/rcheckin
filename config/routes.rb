Rcheckin::Application.routes.draw do
  root :to => 'home#index'

  match "/signin"                  => "authentications#new"
  match "/auth/:provider/callback" => "authentications#create"
end
