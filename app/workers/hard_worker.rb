class HardWorker
  include Sidekiq::Worker
  def perform(auction_id)
    CloseAuction.call(auction_id)
  end
end
