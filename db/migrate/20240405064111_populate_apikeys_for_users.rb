class PopulateApikeysForUsers < ActiveRecord::Migration[7.1]
  def change
    def up
      User.all.each do |user|
        user.update(apikey: SecureRandom.hex(16))
      end
    end

    def down
      # No need to define the down method as it is not reversible
    end
  end
end
