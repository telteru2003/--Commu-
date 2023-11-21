Rails.application.routes.draw do

# 【管理者】 ログイン・ログアウト
  devise_for :admins, controllers: {
    sessions: 'admin/sessions'
  }

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
  	get '/search'=>'search#search'
    # resources :invitations, only: [:new, :edit]
    resources :places, only: [:create, :destroy]
    resources :foods, only: [:index, :new, :edit, :show, :create, :update, :destroy] do
      resources :likes, only: [:create, :destroy]
      member do
        get 'show/:id', to: 'foods#show', as: 'show_food'
        get 'edit' => 'foods#edit', as: 'edit_food'
      end
    end
    resources :family_users, only: [:destroy]
    resources :families, only: [:new, :edit, :show, :permit, :create, :update, :destroy] do
      member do
        get 'show/:id', to: 'families#show', as: 'show_family'
        get 'new' => 'families#new', as: 'new_family'
        get 'permit' => 'families#permit'
        get 'edit' => 'families#edit', as: 'edit_family'
        patch 'update' => 'families#update', as: :update_families
        delete 'destroy', to: 'families#destroy', as: :delete_families
      end
      resource :memberships, only: %i[index create destroy]
      resource :family_users, only: %i[index create destroy]
    end

    get "families/:id/memberships" => "families#memberships", as: :memberships

    resources :users, only: [:index, :show, :update, :destroy] do
      member do
        delete 'destroy', to: 'users#destroy'
      end
    end

    get 'show/users/:id', to: 'users#show', as: 'show_user'
    get 'edit/users' => 'users#edit'
    patch 'update/users' => 'users#update', as: :update_users
    get 'quit/users', to: 'users#quit'
    patch 'out', to: 'users#out'
  end
end
