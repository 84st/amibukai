class CreateMedia < ActiveRecord::Migration[5.2]
  def change
    create_table :media do |t|
      t.string :media_name
      t.integer :post_id

      t.timestamps
    end
  end
end
