class CreateCoasCompanies < ActiveRecord::Migration
  def change
    create_table :coas_companies do |t|
      t.references 'coas'
      t.references 'companies'

    end
  end
end
