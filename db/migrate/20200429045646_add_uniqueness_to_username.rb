class AddUniquenessToUsername < ActiveRecord::Migration
  def change
    def change
      add_index :users, :username, unique: true
    end
  end
end
