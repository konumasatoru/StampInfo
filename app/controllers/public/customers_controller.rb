class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!, except: [:index]
  before_action :set_current_customer
  before_action :set_customer, only: [:likes]
  before_action :ensure_guest_customer, only: [:edit]

  def mypage
    @customer = current_customer # 現在ログインしている顧客の情報を取得するメソッド
    @posts = @customer.posts
    favorites = Favorite.where(customer_id: @customer.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
  end

  def edit
  end

  def index
  end

  def update
    if @customer.update(customer_params)
      redirect_to mypage_path, notice: '会員情報の更新が完了しました。'
    else
      render :edit
    end
  end

  def unsubscribe
  end

  def withdraw
    @customer = current_customer
    @customer.update(status: false)
    reset_session
    redirect_to root_path
  end

  
  
  # いいね投稿一覧
  def favorites
    favorites = Favorite.where(customer_id: @customer.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
  end

  def quit
  end

  private

  def set_current_customer
    @customer = current_customer
  end

  def customer_params
    params.require(:customer).permit(:name, :email)
  end

  def ensure_guest_customer
    @customer = Customer.find(params[:id])
    if @customer.name == "guestuser"
      redirect_to customer_path(current_customer) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end
  
  def set_customer
    @customer = Customer.find(params[:id])
  end
end
