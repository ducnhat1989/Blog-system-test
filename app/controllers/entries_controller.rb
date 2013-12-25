class EntriesController < ApplicationController
	before_action :signed_in_user, only: [:create, :destroy]

	def new
		@entry = Entry.new
	end

	def create
		@entry= current_user.entries.build(entry_params)
	    if @entry.save
	      flash[:success] = "Entry posted!"
	      redirect_to @entry
	    else
	      render 'new'
	    end
	end

	def show
		@entry = Entry.find(params[:id])
		@user_post_entry = User.find(@entry.user_id)
		#@user = current_user
		@comments = @entry.comments
	end

	def destroy
		@entry.destroy
    	redirect_to root_url
	end

	private

	    def entry_params
	      params.require(:entry).permit(:title, :body)
	    end

	    def correct_user
	      
	    end
end
