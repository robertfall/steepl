Tvmethodist::Application.routes.draw do
  root to: 'dashboard#index'
  resources :users
  resources :sessions
  resources :song_sets, path: 'sets' do
    get 'activate', as: :activate
    delete 'deactivate', as: :deactivate
  end
  resources :songs do
    get 'add_to_set', as: :add_to_set
    resources :attachments, only: [:create, :destroy]
  end

  post 'song_set_songs/sort', as: :sort

  match 'logout' => 'sessions#destroy', :as => :logout
  get 'login' => 'sessions#new', :as => :login

  resources :sermons
end
