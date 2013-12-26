class UsersController < ApplicationController
	before_action :signed_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]

	def index
		@users = User.paginate(page: params[:page])
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)    # Not the final implementation!
	    if @user.save
	      sign_in @user
	      flash[:success] = "Welcome to the Blog Framgia!"
	      redirect_to @user
	    else
	      render 'new'
	    end
	end

	def show
		@user = User.find(params[:id])
		@entries = @user.entries.paginate :page => params[:page], :per_page => 3
	end

	def following
	    @title = "Following"
	    @user = User.find(params[:id])
	    @users = @user.followed_users.paginate :page => params[:page], :per_page => 3
	    render 'show_follow'
	end

	def followers
	    @title = "Followers"
	    @user = User.find(params[:id])
	    @users = @user.followers.paginate :page => params[:page], :per_page => 3
	    render 'show_follow'
	end

	private

	    def user_params
	      params.require(:user).permit(:name, :email, :password,
	                                   :password_confirmation)
	    end
end
