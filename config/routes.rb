Tvmethodist::Application.routes.draw do
  get "users/new"

  get "sessions/new"

  root to: 'songs#index'
  resources :song_sets, path: 'sets' do
    get 'activate', as: :activate
  end
  resources :songs do
    get 'add_to_set', as: :add_to_set
    resources :attachments, only: [:create, :destroy]
  end
end
