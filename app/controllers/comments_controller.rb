class CommentsController < ApplicationController

	def new
		@comment = Comment.new
	end

	def create
		entry_current = Entry.find(params[:comment][:entry_id])
		@comment = entry_current.comments.build(comment_params)
	    if @comment.save
	      flash[:success] = "Comment posted!"
	      redirect_to entry_current
		else
		  flash.now[:success] = "Posted Failed!"
		  @entry = Entry.find(params[:comment][:entry_id])
		  @user_post_entry = User.find(@entry.user_id)
		  @comments = @entry.comments
		  render 'entries/show'
		end
	end

	private

	    def comment_params
	      params.require(:comment).permit(:content, :entry_id, :user_id)
	    end
end