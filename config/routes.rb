Webtracks::Application.routes.draw do
  devise_for :users
  resources :users, only: [:update, :show]

  match 'events' => 'events#index', via: :options

  resources 'events', only: [:index, :create]

  get 'about' => 'welcome#about'
  root to: 'welcome#index'
end
