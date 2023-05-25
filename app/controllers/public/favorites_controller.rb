class Public::FavoritesController < ApplicationController
   def create
    @post = Post.find(params[:post_id])
    current_customer.favorites.find_or_create_by(post_id: @post.id)
    #favorite.save
    #redirect_to request.referer
    render 'public/favorites/toggle'
   end

  def destroy
    @post = Post.find(params[:post_id])
    favorite = current_customer.favorites.find_by(post_id: @post.id)
    favorite.destroy if favorite
    #$redirect_to request.referer
    render 'public/favorites/toggle'
  end
end
