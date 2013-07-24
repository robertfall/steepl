Tvmethodist::Application.routes.draw do
  root to: 'dashboard#worship', constraints: PermissionConstraint.new(:read_worship)
  root to: 'members#index', constraints: PermissionConstraint.new(:read_members)
  root to: 'dashboard#worship'

  resources :users
  resources :sessions

  scope path: 'music' do
    resources :song_sets_songs do
      post :sort, on: :collection
    end

    resources :song_sets, path: 'sets'

    resources :songs do
      get 'add_to_set', as: :add_to_set
      resources :attachments, only: [:create, :destroy]
    end
  end

  scope path: 'membership' do
    resources :members
    resources :families
    resources :groups
    resources :group_members, only: [:create, :destroy]
  end

  scope path: 'communication' do
    resources :messages
    resources :message_attachments
    resources :message_recepients
  end

  resources :attachments, only: [:create, :destroy]

  resources :sermons do
    get :downloaded, on: :member
  end

  get 'worship' => 'dashboard#worship', as: 'worship'

  match 'logout' => 'sessions#destroy', :as => :logout
  get 'login' => 'sessions#new', :as => :login
end
