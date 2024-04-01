class RenameTitleToMovieTitleInMovies < ActiveRecord::Migration[7.1]
  def change
    rename_column :movies, :title, :movie_title
  end
end
