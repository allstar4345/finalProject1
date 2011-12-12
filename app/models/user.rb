class User < ActiveRecord::Base
  attr_accessible :name, :email
  
  has_many :microposts
  
  has_many :groups, :foreign_key => "follower_id"
  
  has_many :following, :through => :groups, :source => :leader
  
  has_many :reverse_groups, :foreign_key => "leader_id",
                            :class_name => "Group"
                                   
  has_many :followers, :through => :reverse_groups,
                       :source => :follower
  
  
  email_regexp = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :name, :presence => true,
                   :length => { :maximum => 50}
  
  validates :email, :presence => true,
                    :format => { :with => email_regexp},
                    :uniqueness => {:case_sensitive => false}
                    
                 
                 
  
                    
      
    def following?(leader)
    groups.find_by_leader_id(leader)
  end
  
  def follow!(leader)
    groups.create!(:leader_id =>leader.id)
  end
  
  def unfollow!(leader)
    groups.find_by_leader_id(leader).destroy
  end
end