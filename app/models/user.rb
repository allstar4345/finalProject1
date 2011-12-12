class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :name, :email, :password, :password_confirmation
  
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
                    
  validates :password, :presence => true,
                        :confirmation => true,
                        :length => { :within => 4..40 }   
                        
  before_save :encrypt_password                      
                                      
    def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end
  
  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil if user.nil?
    return user if user.has_password?(submitted_password)
  end
    
    def following?(leader)
    groups.find_by_leader_id(leader)
  end
  
  def follow!(leader)
    groups.create!(:leader_id =>leader.id)
  end
  
  def unfollow!(leader)
    groups.find_by_leader_id(leader).destroy
  end
  
  class << self
    def authenticate(email, submitted_password)
      user = find_by_email(email)
      (user && user.has_password?(submitted_password)) ? user : nil
    end
  def authenticate_with_salt(id, cookie_salt)
      user = find_by_id(id)
      (user && user.salt == cookie_salt) ? user : nil
    end
  end
  
  private
  
    def encrypt_password
      self.salt = make_salt unless has_password?(password)
      self.encrypted_password = encrypt(password)
    end
  
    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end
    
    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end
    
    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
end