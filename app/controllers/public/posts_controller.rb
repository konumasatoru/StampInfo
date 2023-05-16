class Public::PostsController < ApplicationController
  def new
    @post = Post.new
  end
  
  def create
    # １.&2. データを受け取り新規登録するためのインスタンス作成
    post = Post.new(post_params)
    post.customer = current_customer
    # 3. データをデータベースに保存するためのsaveメソッド実行
    if post.save
    #byebug  #continue
    # 4. 投稿一覧画面へリダイレクト
      redirect_to '/posts'
    else
      render :new
    end
  end
  
  def index
    @genres = Genre.all
    @posts = params[:name].present? ? Post.where(genre_id: params[:name]) : Post.all
    @posts = @posts.page(params[:page])
  end
  
  # kensaku you
  # def search
  #   @genres = Genre.all
  #   posts = params[:name].present? ? Genre.find(params[:name]).posts : Post.all
  #   @posts = posts.page(params[:page])
  #   render :index
  # end
  
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
    params.require(:post).permit(:name, :introduction, :genre_id, :price, :image, :seller_url, :customer_id)
  end
end
