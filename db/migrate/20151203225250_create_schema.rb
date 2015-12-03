class CreateSchema < ActiveRecord::Migration
  def change
    create_table :auctions do |t|
      t.string   :item_name
      t.datetime :end_time
      t.integer  :winner_id
    end

    create_table :bids do |t|
      t.integer :auction_id
      t.integer :bidder_id
    end

    create_table :users do |t|
      t.string :name
    end
  end
end
