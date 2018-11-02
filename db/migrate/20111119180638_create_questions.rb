class CreateQuestions < ActiveRecord::Migration
  def up
    create_table :questions do |t|
      t.string  :keyword
      t.index :keyword, unique: true
      t.integer :index
      t.integer :answer
      t.string  :description
      t.float   :weight
      t.integer :subcategory_id
      t.string  :category
      t.timestamps
    end
  end
  
  def down
    drop_table :questions
  end
end
