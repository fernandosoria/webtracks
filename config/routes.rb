Webtracks::Application.routes.draw do
  devise_for :users
  resources :users, only: [:update, :show]

  get 'about' => 'welcome#about'
  root to: 'welcome#index'
end
