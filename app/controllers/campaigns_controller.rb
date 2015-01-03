class CampaignsController < ApplicationController
		before_action :find_campaign, only: [:show, :edit, :update, :destroy]
		before_action :authenticate_user!, except: [:index, :show]
		has_scope :free
		has_scope :open
		has_scope :closed

	def index
		@campaigns = Campaign.all.order("created_at DESC")
		@free_campaign = Campaign.free.first
		@open_campaigns = Campaign.open.all
		@closed_campaigns = Campaign.closed.all

	end

	def show
		@lyrics = Lyric.where(campaign_id: @campaign.id).order("created_at DESC")
		@arts = Art.where(campaign_id: @campaign.id).order("created_at DESC")
		@time = Time.now 
	end

	def new
		@campaign = current_user.campaigns.build
	end

	def create
		@campaign = current_user.campaigns.build(campaign_params)

		if @campaign.save
			redirect_to @campaign
		else
			render 'new'
		end

	end

	def edit
	end

	def update
		if @campaign.update(campaign_params)
			redirect_to @campaign
		else
			render 'edit'
		end

	end

	def destroy
		@campaign.destroy
		redirect_to root_path
	end


	private

	def find_campaign
		@campaign = Campaign.find(params[:id])
	end

	def campaign_params
		params.require(:campaign).permit(:title, :description, :timer, :timer2, :image, :status)
	end

end
