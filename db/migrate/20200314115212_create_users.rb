class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password
      t.string :prefecture
      t.string :area
      t.integer :cultivation_area

      t.timestamps
    end
  end
end
