class UpdateMoviesTable < ActiveRecord::Migration[7.1]
  def change
    rename_column :movies, :movie_title, :title
    remove_column :movies, :review
    remove_column :movies, :release_date

    add_column :movies, :mid, :integer
    add_column :movies, :original_title, :string
    add_column :movies, :overview, :text
    add_column :movies, :poster, :string
    add_column :movies, :popularity, :float
  end
end
