Rcheckin::Application.routes.draw do
  authenticated :user do
    root :to => 'home#index'
    resources :users, :only => [] do
      resource :condition, :only => [ :show ]
    end
  end

  root :to => 'home#index'
  devise_for :users
  resources :users, :only => [ :show, :index ]
end
