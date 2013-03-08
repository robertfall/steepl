Tvmethodist::Application.routes.draw do
  root to: 'dashboard#worship'

  resources :users
  resources :sessions

  scope path: 'music' do
    resources :song_sets_songs do
      post :sort, on: :collection
    end

    resources :song_sets, path: 'sets' do
      get 'activate', as: :activate
      delete 'deactivate', as: :deactivate
    end

    resources :songs do
      get 'add_to_set', as: :add_to_set
      resources :attachments, only: [:create, :destroy]
    end
  end

  resources :members

  resources :sermons do
    get :downloaded, on: :member
  end

  get 'worship' => 'dashboard#worship', as: 'worship'

  match 'logout' => 'sessions#destroy', :as => :logout
  get 'login' => 'sessions#new', :as => :login
end
