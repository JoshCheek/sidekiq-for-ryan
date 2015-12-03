class HardWorker
  include Sidekiq::Worker
  def perform(auction_id)
    auction = Auction.find(auction_id)
    return unless Time.current <= auction.end_time
    last_bid = auction.bids.last
    auction.winner = last_bid.bidder if last_bid
  end
end
