Dir.glob(File.join(Rails.root, 'db', 'seeds_*.rb')).each do |seed_file|
  require seed_file
end
