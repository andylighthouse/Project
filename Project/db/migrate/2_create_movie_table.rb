class CreateMovieTable < ActiveRecord::Migration
  
  def change 
    create_table :movies do |t|
      t.string :title
      t.date :year
      t.integer :gross
      t.string :poster
      t.string :trailer
      t.references :user
      t.timestamps
    end
  end
end



