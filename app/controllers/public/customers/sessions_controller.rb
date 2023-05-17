class Public::Customers::SessionsController < Devise::SessionsController
  def guest_sign_in
    customer = Customer.guest
    sign_in customer
    redirect_to mypage_path, notice: 'guestuserでログインしました。'
  end
end