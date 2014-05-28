MSSD::Application.routes.draw do

  get 'samples/list'

  get 'feeds/list'

  get 'feeds/new_feed'

  post 'feeds/create' => "feeds#new_feed"
  resources :add_feed, :controller => "feeds", :as => :add_feed

  get 'search/search'

  root :to => "home#index"
  devise_for :users, :path_names => {:sign_in => "login", :sign_out => "logout"}, :path => "d"
  resources :users
  namespace :admin do
    get '/' => 'users#index'
    resources :users
  end
end