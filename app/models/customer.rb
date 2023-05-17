class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :comments, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  def self.guest
    find_or_create_by!(name: 'guestuser' ,email: 'guest@example.com') do |customer|
      customer.password = SecureRandom.urlsafe_base64
      customer.name = "guestuser"
    end
  end

         
         # 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @customer = Customer.where("name LIKE?", "#{word}")
    elsif search == "forward_match"
      @customer = Customer.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
      @customer = Customer.where("name LIKE?","%#{word}")
    elsif search == "partial_match"
      @customer = Customer.where("name LIKE?","%#{word}%")
    else
      @customer = Customer.all
    end
  end
end
