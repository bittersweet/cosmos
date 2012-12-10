class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.integer :user_id
      t.string :title
      t.string :file
      t.timestamps
    end

    add_index :tracks, :user_id
  end
end
