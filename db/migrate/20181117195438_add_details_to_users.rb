class AddDetailsToUsers < ActiveRecord::Migration
  def change
    ## Well, uh, here's my shit I guess
    add_column :users, :role, :string
    #add_reference :users, :companies, index:true
    add_foreign_key :users, :companies, column: :id
  end
end
