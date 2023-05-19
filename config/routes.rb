Rails.application.routes.draw do

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions",
}

namespace :admin do
    get "search" => "searches#search"
    get 'top' => 'homes#top', as: 'top'
    resources :customers do
     collection do
       patch 'withdraw'
     end
   end
    resources :customers, only: [:index, :show, :edit, :update]
    resources :posts, except: [:destroy]
    resources :genres, only: [:index, :create, :edit, :update]
    resource :favorites, only: [:create, :destroy]
    resources :posts
  end

    # 顧客用
# URL /customers/sign_in ...
devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

scope module: :public do
  devise_scope :customer do
    post 'customers/guest_sign_in', to: 'customers/sessions#guest_sign_in'
  end

    get "search" => "searches#search"
    root 'homes#top'
    post 'posts' => 'posts#create'
    resources :posts

    resource :customers do
  		collection do
  	     get 'quit'
  	     patch 'withdraw'
  	  end
  	 end

    get 'customers/mypage' => 'customers#mypage', as: 'mypage'
    # customers/editのようにするとdeviseのルーティングとかぶってしまうためinformationを付け加えている。
    get 'customers/information/edit' => 'customers#edit', as: 'edit_information'
    patch 'customers/information' => 'customers#update', as: 'update_information'
    get 'customers/unsubscribe' => 'customers#unsubscribe', as: 'confirm_unsubscribe'
    put 'customers/information' => 'customers#update'
    patch 'customers/withdraw' => 'customers#withdraw', as: 'withdraw_customer'
    resources :posts, only: [:new, :create, :index, :show, :destroy] do
    resources :comments, only: [:create]
    resource :favorites, only: [:create, :destroy]
  end

    resources :customers, only: [:index, :show, :edit, :update]
    resources :posts, only: [:edit, :new, :index, :show, :create, :destroy, :update]

    resources :customers do
  member do
    get :likes
  end
end
  end
end
