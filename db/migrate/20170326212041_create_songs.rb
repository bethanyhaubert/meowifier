class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :file
      t.string :title
      t.string :meowified_file
      t.timestamps null: false
    end
  end
end
