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
    resources :invitations, only: [:new, :edit]
    resources :foods, only: [:index, :new, :create]
    resources :families, only: [:edit, :show, :update, :destroy] do
      member do
        get 'show/:id', to: 'families#show', as: 'show_family'
        get 'edit' => 'families#edit'
        patch 'update' => 'families#update', as: :update_families
      end
    end


    resources :users, only: [:index, :show, :update, :destroy] do
      member do
        delete 'destroy', to: 'users#destroy'
      end

      # collection do
      #   get 'search_family'
      # end

    end

      get 'show/users/:id', to: 'users#show', as: 'show_user'
      get 'edit/users' => 'users#edit'
      patch 'update/users' => 'users#update', as: :update_users

      get 'quit/users', to: 'users#quit'
      patch 'out', to: 'users#out'
    end
  end
