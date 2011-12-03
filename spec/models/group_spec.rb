require 'spec_helper'

describe Group do
  before (:each) do
     @follower = Factory(:user)
     @leader = Factory(:user, :email => Factory.next(:email))
     @group = @follower.groups.build(:leader_id =>@leader.id)
  end
  
  it "should create a new group given valid attributes" do
    @group.save!
  end
  
  describe "validations" do
    it "should require a follower_id" do
      @group.should respond_to(:follower)
     end
   end
  
  it "should create a new group given valid attributes" do
     #@group.save!
  end
  
end