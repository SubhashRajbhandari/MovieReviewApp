require_relative '../../app/services/tmdb/all_service'
require_relative '../../app/services/tmdb/detail_service'
require_relative '../../app/services/tmdb/search_service'
class MoviesController < ApplicationController
  # before_action :authenticate_user!
  def index
    if params[:movie_title].present?
      @movies = Tmdb::SearchService.execute(title: params[:movie_title])
    else
      @movies = Tmdb::AllService.execute()
    end
  end

  def show
    @movie = Tmdb::DetailService.execute(id: params[:id])
  end

  def new
    
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
