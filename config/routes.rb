Rcheckin::Application.routes.draw do
  root :to => 'home#index'
  resource :condition, :only => [ :show, :update ]
  resources :users, :only => [ :show, :index ]
end
