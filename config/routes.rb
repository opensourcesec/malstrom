Malstrom::Application.routes.draw do

  get 'samples/list'

  get 'threats/tags'

  get 'threats/ioc_list'

  get 'threats/profiles'

  get 'threats/analysis'

  get 'feeds/ioc'

  get 'feeds/import'

  post 'feeds/import' => "feeds#extract"
  resources :extract, :controller => "feeds"

  get 'feeds/list'

  get 'feeds/new_feed'

  post 'feeds/add_feed' => "feeds#create"
  resources :add_feed, :controller => "feeds"

  get 'feeds/run_feed' => "feeds#run_feed"
  resources :run_feed, :controller => "feeds"

  get 'feeds/delete_feed' => "feeds#delete_feed"
  resources :delete_feed, :controller => "feeds"

  get 'search/delete_iocs' => "search#delete_iocs"

  get 'search/indicators'

  get 'search/index'

  post 'search/index'

  post 'search/indicators' => "search#index"

  get "samples/list/yara" => 'samples#yara', :as => :samples_yara
  resources :yara, :controller => "samples"

  get "samples/download_malz", :to => "samples#download_malz"

  get "samples/list/upload" => 'samples#upload', :as => :samples_upload
  resources :upload, :controller => "samples"

  post "samples/list" => "samples#upload_malz"

  get 'samples/delete_sample' => "samples#delete_malz"
  resources :delete_malz, :controller => "samples"

  get "samples/analysis" => "samples#analysis"

  post "samples/add_note" => "samples#add_note"

  get "samples/remove_rule" => "samples#remove_rule"

  get "samples/new_yara" => "samples#new_yara"

  post "samples/save_sig" => "samples#process_sig"

  post "samples/addrule" => "samples#add_rule"

  #if Rails.env.production?
  #devise_for :users, :controllers => { :registrations => "registrations" } 
  #else
  devise_for :users, :path_names => {:sign_in => "login", :sign_out => "logout"}, :path => "d"
  resources :users
  #end

  root :to => "home#index"
  namespace :admin do
    get '/' => 'users#index'
    resources :users
  end
end
