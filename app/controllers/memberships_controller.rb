class MembershipsController < ApplicationController
    before_action :require_user!
    before_action :set_club
    before_action :set_membership, only: [:approve, :reject]
    before_action -> { authorize_owner!(@club) }, only: [:approve, :reject]

    def create
        # Create a pending membership request
        membership = current_user.memberships.find_or_initialize_by(club: @club)
        
        if membership.persisted?
            # Membership already exists
            if membership.approved?
                redirect_to club_path(@club), notice: "You are already a member of this club."
            elsif membership.pending?
                redirect_to club_path(@club), notice: "Your request to join this club is pending approval."
            elsif membership.rejected?
                # Allow re-requesting after rejection
                membership.update!(status: "pending")
                redirect_to club_path(@club), notice: "Your request to join this club has been submitted."
            end
        else
            # New membership request
            membership.status = "pending"
            membership.save!
            redirect_to club_path(@club), notice: "Your request to join this club has been submitted."
        end
    end

    def destroy
        current_user.memberships.where(club: @club).destroy_all
        redirect_to club_path(@club), notice: "You have left the club."
    end
    
    def approve
        @membership.update!(status: "approved")
        redirect_to pending_requests_club_path(@club), notice: "#{@membership.user.name} has been approved as a member."
    end
    
    def reject
        @membership.update!(status: "rejected")
        redirect_to pending_requests_club_path(@club), notice: "#{@membership.user.name}'s request has been rejected."
    end

    private

    def set_club
        @club = Club.find(params[:club_id])
    end
    
    def set_membership
        @membership = @club.memberships.find(params[:id])
    end
end
