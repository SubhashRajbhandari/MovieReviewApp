class V1::ReviewsController < ApplicationController
  # skip_before_action :authenticate_user!, only: [:create]
  skip_before_action :verify_authenticity_token, only: [:create]
    def index
      #  movie = Movie.find(params[:movie_id])

      movie = Movie.find_by(mid: params[:movie_id])
      if movie.nil?

        @movie = fetch_movie(params[:movie_id])
          if @movie['id'].nil?
            render json: { error: 'movie not found in tmdb' }, status: :not_found
              else
                  @movie = Movie.find_by(mid: @movie['id']) || Movie.create(mid: @movie['id'], title: @movie['title'], original_title: @movie['original_title'], overview: @movie['overview'], poster: @movie['poster_path'], popularity: @movie['popularity'])

                  reviews = @movie.reviews.map { |review| { user_id: review.user_id, thereview: review.description } }
                  render json: {TotalReview: reviews.count, movie_id: @movie.mid, reviews: reviews }
              end
            else
          reviews = movie.reviews.map { |review| { user_id: review.user_id, thereview: review.description } }
          render json: {TotalReview: reviews.count, movie_id: movie.mid, reviews: reviews }
          end
  end

def create
  movie = Movie.find_by(mid: params[:movie_id])

  if movie.nil?
    render json: { error: 'Movie not found' }, status: :not_found
  else
    review = movie.reviews.build(review_params)
    review.user_id = 1
    if review.save
      render json: { message: 'Review created successfully', review_id: review.id }, status: :created
    else
      render json: { error: 'Failed to create review', errors: review.errors.full_messages }, status: :unprocessable_entity
    end
  end
end

private

def review_params
  params.require(:review).permit(:description)
end

private

def fetch_movie(movie_id)
  Tmdb::DetailService.execute(id: movie_id)
end

end
