class Post < ApplicationRecord
  
  has_one_attached :image
  has_many :comments, dependent: :destroy
  belongs_to :customer
  has_many :favorites, dependent: :destroy
  
  validates :name, presence: true
  
  def favorited_by?(customer)
    favorites.where(customer_id: customer.id).exists?
  end
  
  # 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @post = Post.where("name LIKE?","#{word}")
    elsif search == "forward_match"
      @post = Post.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
      @post = Post.where("name LIKE?","%#{word}")
    elsif search == "partial_match"
      @post = Post.where("name LIKE?","%#{word}%")
    else
      @post = Post.all
    end
  end
end
