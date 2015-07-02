class CampaignsController < ApplicationController
		before_action :find_campaign, only: [:show, :edit, :update, :destroy]
		before_action :authenticate_user!, except: [:index, :show]
		has_scope :free
		has_scope :open
		has_scope :closed
		has_scope :chosen
		has_scope :draft

	def index
		@campaigns = Campaign.all.order("created_at DESC")
		@free_campaign = Campaign.free.first
		@open_campaigns = Campaign.open.all.order("created_at DESC")
		@closed_campaigns = Campaign.closed.all.order("created_at DESC")
		@draft_campaigns = Campaign.draft.all.order("created_at DESC")


	end

	def show
		@chosen_lyrics = Lyric.chosen.where(campaign_id: @campaign.id)
		@chosen_arts = Art.chosen.where(campaign_id: @campaign.id)
		@lyrics = Lyric.where(campaign_id: @campaign.id).order(:cached_votes_up => :desc)
		@arts = Art.where(campaign_id: @campaign.id).order(:cached_weighted_total => :desc)
		@time = Time.now 

		if @campaign == Campaign.open.last
			@next_campaign = Campaign.open.order(id: :asc).first
		else
			@next_campaign = Campaign.open.where("id > ?", @campaign).order(id: :asc).first
		end

		if @campaign == Campaign.open.first
			@previous_campaign = Campaign.open.order(id: :asc).last
		else
			@previous_campaign = Campaign.open.where("id < ?", @campaign).order(id: :desc).first
		end
	end

	def new
		@campaign = current_user.campaigns.build
		@chosen_lyrics = Lyric.chosen.where(campaign_id: @campaign.id)
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
		params.require(:campaign).permit(:title, :description, :timer, :timer2, :image, :status, :artist, :song, :album, :link, :reward, :credit, :creditlink, :rules, :personal)
	end

end
