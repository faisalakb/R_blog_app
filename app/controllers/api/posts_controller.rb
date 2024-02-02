 # app/controllers/api/posts_controller.rb
class Api::PostsController < ApplicationController
    def index
      user = User.find(params[:user_id])
      posts = user.posts
      render json: { user_id: user.id, posts: posts }
    end
end
  