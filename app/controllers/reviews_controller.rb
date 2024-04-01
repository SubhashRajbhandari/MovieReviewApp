class ReviewsController < ApplicationController
    def create
      @movie = movie.find(params[:post_id])
      @comment = @post.comments.create(comment_params.merge(user_id: current_user.id))
      if @comment.valid?
        redirect_to @movie
      else
        flash[:alert] = "Invalid params"
        redirect_to @movie
      end
    end
    private
    def comment_params
      params.require(:comment).permit(:description, :post_id)
    end

end
