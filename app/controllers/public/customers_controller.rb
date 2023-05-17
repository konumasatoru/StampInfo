class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_current_customer
  before_action :set_customer, only: [:likes]
  before_action :ensure_guest_customer, only: [:edit]

  def mypage
    @customer = current_customer # 現在ログインしている顧客の情報を取得するメソッド
    @posts = @customer.posts
  end

  def edit
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
  
  def likes
    likes = Like.where(customer_id: @customer.id).pluck(:post_id)
    @like_posts = Post.find(likes)
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
end
