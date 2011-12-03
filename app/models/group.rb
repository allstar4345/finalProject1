class Group < ActiveRecord::Base
  
  attr_accessible :leader_id
  
  belongs_to :follower, :class_name => "User"
  belongs_to :leader, :class_name => "User"
  
  validates :follower_id, :presence => true
  validates :leader_id, :presence => true
end
