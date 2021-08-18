Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get 'home/about' => 'homes#about'
  resources :books, only: [:create, :index, :show, :destroy,:update,:edit]
  resources :users, only: [:show, :edit,:create,:index,:update]
  post 'users/:id' => 'users#create'

end
