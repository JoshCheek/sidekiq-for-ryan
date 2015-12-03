josh = User.create! name: 'Josh'
ryan = User.create! name: 'Ryan'

Auction.create! do |a|
  a.item_name = 'Joshs Lamp'
  a.end_time  = 1.minute.from_now
  a.bids.build bidder: josh
end

Auction.create! do |a|
  a.item_name = 'Ryans Tablecloth'
  a.end_time  = Time.current
  a.bids.build bidder: ryan
end

Auction.create! do |a|
  a.item_name = 'Ryan wins the armchair'
  a.end_time  = 1.minute.ago
  a.bids.build bidder: josh
  a.bids.build bidder: ryan
end

Auction.create! do |a|
  a.item_name = 'No one wants the fruitcake'
  a.end_time  = 1.minute.ago
end
