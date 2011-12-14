<<<<<<< HEAD
Ownership.create(:name => "Currently own")
Ownership.create(:name => "Want to buy")
Ownership.create(:name => "Want to sell")
=======
Dir.glob(File.join(Rails.root, 'db', 'seeds_*.rb')).each do |seed_file|
  require seed_file
end
>>>>>>> d08efe474ee64a4c5f6d3950db67dc3d631819ad
