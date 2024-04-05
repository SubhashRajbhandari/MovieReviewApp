class AddApikeyToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :apikey, :string
  end
end
