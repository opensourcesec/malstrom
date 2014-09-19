MSSD::Application.routes.draw do

  get 'samples/list'

  get 'feeds/list'

  get 'feeds/new_feed'

  post 'feeds/add_feed' => "feeds#create"
  resources :add_feed, :controller => "feeds"

  get 'feeds/run_feed' => "feeds#run_feed"
  resources :run_feed, :controller => "feeds"

  get 'search/indicators'

  get 'samples/list/_samples' => "samples#samples"
  resources :samples, :controller => "samples"

  get 'samples/list/_signatures' => "samples#signatures"
  resources :signatures, :controller => "samples"

  get 'samples/list/_upload' => "samples#upload"
  resources :upload, :controller => "samples"

  root :to => "home#index"
  devise_for :users, :path_names => {:sign_in => "login", :sign_out => "logout"}, :path => "d"
  resources :users
  namespace :admin do
    get '/' => 'users#index'
    resources :users
  end
end