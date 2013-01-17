Tvmethodist::Application.routes.draw do

  root to: 'songs#index'
  resources :users
  resources :sessions
  resources :song_sets, path: 'sets' do
    get 'activate', as: :activate
  end
  resources :songs do
    get 'add_to_set', as: :add_to_set
    resources :attachments, only: [:create, :destroy]
  end

  match 'logout' => 'sessions#destroy', :as => :logout
  get 'login' => 'sessions#new', :as => :login
end
