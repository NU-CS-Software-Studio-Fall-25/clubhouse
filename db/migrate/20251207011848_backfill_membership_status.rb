class BackfillMembershipStatus < ActiveRecord::Migration[8.0]
  def up
    # Update all existing memberships that don't have a status or have 'pending' 
    # to 'approved' since they were created before the approval system
    # This assumes all existing memberships were implicitly approved
    Membership.where(status: 'pending').update_all(status: 'approved')
  end
  
  def down
    # We can't really revert this data change meaningfully
    # but we can set them back to pending if needed
    # In practice, this shouldn't be rolled back
  end
end
