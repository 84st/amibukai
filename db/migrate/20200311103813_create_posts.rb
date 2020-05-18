class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :item
      t.string :work
      t.text :report

      t.timestamps
    end
  end
end
