class AuctionsController < ApplicationController
  def index
    json = Auction.all.map do |a|
      { item_name: a.item_name,
        end_time:  a.end_time,
        winner_id: a.winner_id,
        bidders:   a.bids.map(&:bidder)
      }
    end

    render json: json
  end
end
