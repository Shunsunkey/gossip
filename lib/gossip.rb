require 'csv'

class Gossip
  attr_accessor :id, :author, :content

  def initialize(author, content)
    @id = generate_unique_id
    @author = author
    @content = content
  end

  def save
    CSV.open(File.join(File.dirname(__FILE__), "../db/gossip.csv"), "ab") do |csv|
      csv << [id, author, content]
    end
  end

  def self.all
    all_gossips = []
    CSV.foreach(File.join(File.dirname(__FILE__), "../db/gossip.csv")) do |row|
      gossip = Gossip.new(row[0], row[1])
      all_gossips << gossip
    end
    all_gossips
  end

  def self.find(id)
    gossip_found = nil
    CSV.foreach(File.join(File.dirname(__FILE__), "../db/gossip.csv")) do |row|
      if row[0].to_i == id
        gossip_found = Gossip.new(row[1], row[2])
        break # Sort de la boucle une fois que le gossip est trouvé
      end
    end
    gossip_found
  end

  private

  def generate_unique_id
    # Chargement des IDs existants à partir du fichier CSV
    existing_ids = []
    CSV.foreach(File.join(File.dirname(__FILE__), "../db/gossip.csv")) do |row|
      existing_ids << row[0].to_i
    end

    # Trouver le prochain ID unique en incrémentant le maximum d'IDs existants
    next_id = existing_ids.empty? ? 1 : existing_ids.max + 1
    next_id
  end
end
