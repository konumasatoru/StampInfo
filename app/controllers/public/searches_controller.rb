class Public::SearchesController < ApplicationController
    before_action :authenticate_customer!

  def search
    @range = params[:range]
#byebug
    if @range == "Customer"
      @customers = Customer.looks(params[:search], params[:word])
    else
      @posts = Post.looks(params[:search], params[:word])
    end
  end
end
