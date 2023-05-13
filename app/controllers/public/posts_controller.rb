class Public::PostsController < ApplicationController
  def new
    @post = Post.new
  end
  
  def create
    # １.&2. データを受け取り新規登録するためのインスタンス作成
    post = Post.new(post_params)
    # 3. データをデータベースに保存するためのsaveメソッド実行
    post.save
    # 4.　投稿一覧画面へリダイレクト
    redirect_to '/posts'
  end
  
  def index
     @posts = Post.page(params[:page])
  end
  
  def show
    @post = Post.find(params[:id])
  end
  
  def edit
    @post = Post.find(params[:id])
  end
  
   private
  # ストロングパラメータ
  def post_params
    params.require(:post).permit(:name, :introduction, :genre_id, :price, :image)
  end
end
