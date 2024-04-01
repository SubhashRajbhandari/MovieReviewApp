class CreateMovies < ActiveRecord::Migration[7.1]
  def change
    create_table :movies do |t|
      t.string :title
      t.text :review
      t.date :release_date

      t.timestamps
    end
  end
end