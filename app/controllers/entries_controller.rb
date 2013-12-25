class EntriesController < ApplicationController

	def new
		@entry = Entry.new
	end

	def create
		@entry= current_user.entries.build(entry_params)
	    if @entry.save
	      flash[:success] = "Entry posted!"
	      redirect_to root_url
	    else
	      #@feed_items = []
	      render 'static_pages/home'
	    end
	end

	def show
		@entry = Entry.find(params[:id])
		@user = current_user
		@comments = @entry.comments
	end

	private

	    def entry_params
	      params.require(:entry).permit(:title, :body)
	    end

	    def correct_user
	      
	    end
end
