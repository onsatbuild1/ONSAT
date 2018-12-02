class CreateSubs < ActiveRecord::Migration
  def self.up
    create_table :subs, id: false do |t|
      t.integer :company_id
      t.integer :sub_company_id
    end

    add_index(:subs, [:company_id, :sub_company_id], :unique => true)
    add_index(:subs, [:sub_company_id, :company_id], :unique => true)
  end

  def self.down
      remove_index(:subs, [:friend_user_id, :user_id])
      remove_index(:subs, [:user_id, :friend_user_id])
      drop_table :subs
  end
end
