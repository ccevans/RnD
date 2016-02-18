class ArchivesController < ApplicationController
	before_action :find_archive, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!, except: [:index, :show]

	def index
		@archives = Archive.all.order("created_at ASC")
	end

	def show

	end

	def new
		@archive = current_user.archives.build
	end


	def create
		@archive = current_user.archives.build(archive_params)
		if @archive.save
			redirect_to action: "index"
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @archive.update(archive_params)
			redirect_to @archive
		else
			render 'edit'
		end

	end

	def destroy
		@archive.destroy
		redirect_to root_path
	end


private

	def find_archive
		@archive = Archive.find(params[:id])
	end

	def archive_params
		params.require(:archive).permit(:title,:link)
	end

end
