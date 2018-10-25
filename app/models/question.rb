class Question < ActiveRecord::Base

    def self.upload(file)
        accessible_attributes = ['keyword','index', 'answer', 'weight']
        CSV.foreach(file.path, headers: true) do |row|
            question = find_by_id(row["index"]) || new
            question.attributes = row.to_hash.slice(*accessible_attributes)
            product.save!
        end
    end
#     def self.import(file)
#     accessible_attributes = ['my_attribute_name1','my_attribute_name2', '...']
#     spreadsheet = open_spreadsheet(file)
#     header = spreadsheet.row(1)
#     (2..spreadsheet.last_row).each do |i|
#       row = Hash[[header, spreadsheet.row(i)].transpose]
#       cae = find_by_id(row["id"]) || new
#       cae.attributes = row.to_hash.slice(*accessible_attributes)
#       cae.save!
#   end
end
