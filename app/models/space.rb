class Space < ActiveRecord::Base

  validates :name, presence:   true,
                  length: { maximum: 50 }, 
                  uniqueness: true

=begin
  require 'csv'

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      space = find_by_id(row["id"]) || new
      space.attributes = row.to_hash.slice(:name)
      space.save!
    end
  end
=end
end
