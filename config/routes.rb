Steepl::Application.routes.draw do
  get '/', to: 'dashboard#worship', constraints: PermissionConstraint.new(:read_worship)
  get '/', to: 'members#index', constraints: PermissionConstraint.new(:read_members)
  root to: 'dashboard#worship'

  get 'worship' => 'dashboard#worship', as: 'worship'
  get 'login' => 'sessions#new', :as => :login
  match 'logout' => 'sessions#destroy', :as => :logout, via: [:get, :post]

  resources :users
  resources :sessions

  scope path: 'music' do
    resources :song_sets_songs do
      post :sort, on: :collection
    end

    resources :song_sets, path: 'sets'

    resources :songs do
      get 'add_to_set', as: :add_to_set
      resources :attachments, only: [:create, :destroy], controller: :song_attachments
    end
  end

  scope path: 'membership' do
    resources :offerings
    resources :members do
      resources :notes
    end
    resources :families
    resources :groups
    resources :group_members, only: [:create, :destroy]
  end

  scope path: 'communication' do
    resources :messages
    resources :message_attachments
    resources :message_recipients
  end

  resources :attachments, only: [:create, :destroy]

  resources :sermons do
    get :downloaded, on: :member
  end

end
