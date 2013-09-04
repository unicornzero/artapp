class SpaceImport
  require 'csv'
  include ActiveModel::Model

  attr_accessor :file

  def initialize(attributes = {})
    attributes.each { |name, value| send("#{name}=", value) }
  end

  def persisted?
    false
  end

  def save
    if imported_spaces.map(&:valid?).all?
      imported_spaces.each(&:save!)
      true
    else
      imported_spaces.each_with_index do |space, index|
        space.errors.full_messages.each do |message|
          errors.add :base, "Row #{index+2}: #{message}"
        end
      end
      false
    end
  end

  def imported_spaces
    @imported_spaces ||= load_imported_spaces
  end

  def load_imported_spaces
    file_spaces = []
    CSV.foreach(file.path, headers: true) do |row|
      if space = Space.find_by(id: row["id"])
      elsif space = Space.find_by(name: row["name"])
      else
        space = Space.new
      end
      space.name = row["name"]
      space.url = row["url"]
      space.save!
      file_spaces << space
    end
    file_spaces
  end



end