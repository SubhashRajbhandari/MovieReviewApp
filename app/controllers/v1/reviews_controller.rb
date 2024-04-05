class V1::ReviewsController < ApplicationController
  # before_action :authenticate_user!, only: [:create]
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user_using_api_key
    def index
      #  movie = Movie.find(params[:movie_id])

      movie = Movie.find_by(mid: params[:movie_id])
      if movie.nil?

        @movie = fetch_movie(params[:movie_id])
        # binding.irb
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
  unless current_user
    render json: { error: 'User not authenticated' }, status: :unauthorized
    return
  end

  if movie.nil?
    @movie = fetch_movie(params[:movie_id])
          # if response.code == 404
           if @movie['id'].nil?
            render json: { error: 'movie not found in tmdb' }, status: :not_found
              else
                @movie = Movie.find_by(mid: @movie['id']) || Movie.create(mid: @movie['id'], title: @movie['title'], original_title: @movie['original_title'], overview: @movie['overview'], poster: @movie['poster_path'], popularity: @movie['popularity'])
                review = @movie.reviews.build(review_params)
                review.user_id = current_user.id
                if review.save
                  render json: { message: 'Review created successfully', review_id: review.id }, status: :created
                else
                  render json: { error: 'Failed to create review', errors: review.errors.full_messages }, status: :unprocessable_entity
                end
          end
  else

    review = movie.reviews.build(review_params)
    review.user_id = current_user.id

    if review.save
      render json: { message: 'Review created successfully', review_id: review.id }, status: :created
    else
      render json: { error: 'Failed to create review', errors: review.errors.full_messages }, status: :unprocessable_entity
    end
  end
end

private

def authenticate_user_using_api_key
  api_key = request.headers['x-api-key']
  @current_user = User.find_by(apikey: api_key)
  unless @current_user
    render json: { error: 'User not authenticated' }, status: :unauthorized
  end
  # api_key = request.headers['x-api-key']
  # unless api_key && user = User.find_by(apikey: api_key)
  #   render json: { error: 'Unauthorized' }, status: :unauthorized
  # end
end

def review_params
  params.require(:review).permit(:description)
end


def fetch_movie(movie_id)
  Tmdb::DetailService.execute(id: movie_id)
end

end
