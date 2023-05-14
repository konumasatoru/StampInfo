class Admin::PostsController < ApplicationController
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
    @comment = Comment.new
  end
  
  def edit
    @post = Post.find(params[:id])
    @genres = Genre.all
  end
  
  def destroy
    post = Post.find(params[:id])  # データ（レコード）を1件取得
    post.destroy  # データ（レコード）を削除
    redirect_to '/posts'  # 投稿一覧画面へリダイレクト  
  end
  
  def update
    post = Post.find(params[:id])
    post.update(post_params)
    redirect_to post_path(post.id)  
  end
  
   private
  # ストロングパラメータ
  def post_params
    params.require(:post).permit(:name, :introduction, :genre_id, :price, :image, :seller_url)
  end
end
