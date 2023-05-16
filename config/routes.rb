Rails.application.routes.draw do

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions",
}

namespace :admin do
    get "search" => "searches#search"
    get 'top' => 'homes#top', as: 'top'
    resources :customers, only: [:index, :show, :edit, :update]
    resources :posts, except: [:destroy]
    resources :genres, only: [:index, :create, :edit, :update]
    resource :favorites, only: [:create, :destroy]
  end
  
    # 顧客用
# URL /customers/sign_in ...
devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

scope module: :public do
    get "search" => "searches#search"
    root 'homes#top'
    post 'posts' => 'posts#create'
    
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
  end
end
