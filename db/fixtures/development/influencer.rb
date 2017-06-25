influencers =  Array.new(100) do |i|
  { name: "name #{i}", email: "test#{i}@example.com" }
end
Influencer.seed(:name, influencers)
