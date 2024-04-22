require 'csv'

class Gossip
  attr_accessor :author, :content, :id

  def initialize(author, content)
    @author = author
    @content = content
    @id = generate_id
  end

  def save
    FileUtils.mkdir_p("db") unless File.directory?("db")
    csv_path = "db/gossip.csv"
    CSV.open(csv_path, "a") do |csv|
      csv << [@id, author, content]
    end
  end

  def self.all
    all_gossips = []
    CSV.foreach("db/gossip.csv") do |csv_line|
      all_gossips << Gossip.new(csv_line[1], csv_line[2])
    end
    return all_gossips
  end

  def self.find(id)
    all_gossips = self.all
    all_gossips.each do |gossip|
      return gossip if gossip.id == id.to_i
    end
    return nil
  end

  private

  def generate_id
    # Récupérer tous les IDs existants dans le fichier CSV
    existing_ids = CSV.read("db/gossip.csv").map { |csv_line| csv_line[0].to_i }
    # Trouver le plus grand ID
    max_id = existing_ids.max || 0
    # Incrémenter le plus grand ID pour obtenir un nouvel ID unique
    new_id = max_id + 1
    return new_id
  end
end
