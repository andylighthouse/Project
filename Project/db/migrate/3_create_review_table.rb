class CreateReviewTable < ActiveRecord::Migration

  def change
    create_table :reviews do |t|
      t.string :comment
      t.string :rating
      t.string :recommend
      t.references :movie
      t.references :user
      t.timestamp
    end
  end
end

