class Auction < ActiveRecord::Base
  has_many :bids
  has_many :bidders, through: :bids
  belongs_to :winner, class_name: 'User'
end
