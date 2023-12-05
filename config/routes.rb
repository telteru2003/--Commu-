Rails.application.routes.draw do

# 【管理者】

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    :sessions => 'admin/sessions',
    :registrations => 'admin/registrations',
  }

  namespace :admin do
    get 'homes' => 'homes#index', as: 'homes'
  	get '/search'=>'search#search'
  	resources :families, only: [:index, :destroy]
    resources :users, only: [:index, :update]
  	resources :foods, only: [:index, :destroy]
  	resources :comments, only: [:index, :destroy]
    resources :homes, only: [:index]
  end

# 【ユーザー】 新規登録・ログイン・ログアウト
  devise_for :users, controllers: {
    sessions: 'public/sessions',
    passwords: 'public/passwords',
    registrations: 'public/registrations',
    invitations: 'devise/invitations'
  }

# 【ユーザー】 ゲストログイン
  devise_scope :user do
    post "/sessions/guest_sign_in" => "public/sessions#guest_sign_in"
    resources :users, only: [:show]
  end

# ルート設定
  root 'public/homes#top'

# 【ユーザー】 ログイン後のリダイレクト先
  authenticated :user do
    root 'public/foods#index', as: :authenticated_root
  end

  scope module: :public do
    get '/search' => 'search#search'
    resources :places, only: [:create, :destroy]

    resources :foods do
      resources :likes, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]

      member do
        get 'show', as: 'show_food'
        get 'edit', as: 'edit_food'
      end
    end

    resources :family_users, only: [:destroy]

    resources :families do
      member do
        get 'show', as: 'show_family'
        get 'new', as: 'new_family'
        get 'permit'
        get 'edit', as: 'edit_family'
        patch 'update', as: :update_families
        delete 'destroy', as: :delete_families
      end

      resource :memberships, only: %i[index create destroy] do
        delete 'destroy', on: :member, as: :delete_membership
      end

      resource :family_users, only: %i[index create destroy]
    end

    get "families/:id/memberships" => "families#memberships", as: :memberships

    resources :users, only: [:index, :show, :update, :destroy] do
      delete 'destroy', on: :member
    end

    get 'show/users/:id', to: 'users#show', as: 'show_user'
    get 'edit/users' => 'users#edit'
    patch 'update/users' => 'users#update', as: :update_users
    get 'quit/users', to: 'users#quit'
    patch 'out', to: 'users#out'
  end

end