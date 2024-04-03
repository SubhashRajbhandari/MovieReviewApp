class V1::ReviewsController < ApplicationController
  def index
    movie = Movie.find(params[:movie_id])
    reviews = movie.reviews.map { |review| { user_id: review.user_id, thereview: review.description } }
    render json: { mid: movie.id, reviews: reviews }
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Movie not found' }, status: :not_found
  end
end
