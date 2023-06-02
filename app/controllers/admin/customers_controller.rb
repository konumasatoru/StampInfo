class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!
  before_action :ensure_customer, only: [:show, :edit, :update]

  def index
    @customers = Customer.page(params[:page])
  end

  def show
  end

  def edit
  end

  def update
    @customer.update(customer_params) ? (redirect_to admin_customer_path(@customer)) : (render :edit)
  end

  def withdraw
    @customer = Customer.find(params[:id])
    @customer.update(status: false)
    redirect_to admin_customer_path(@customer)
  end
  
  def destroy
  @comment = Comment.find(params[:id])
  if @comment.destroy
    redirect_to post_path(@post), notice: 'コメントを削除しました'
  else
    flash.now[:alert] = 'コメント削除に失敗しました'
    render post_path(@post)
  end
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :email, :status)
  end

  def ensure_customer
    @customer = Customer.find(params[:id])
  end
end
