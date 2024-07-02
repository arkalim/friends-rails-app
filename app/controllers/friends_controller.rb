class FriendsController < ApplicationController
  before_action :set_friend, only: %i[show edit update destroy]
  before_action :authenticate_user!

  # GET /friends or /friends.json
  def index
    @friends = current_user.friends
    filter_friends
    sort_friends
  end

  # GET /friends/1 or /friends/1.json
  def show; end

  # GET /friends/new
  def new
    @friend = Friend.new
  end

  # GET /friends/1/edit
  def edit; end

  # POST /friends or /friends.json
  def create
    @friend = Friend.new(friend_params)

    respond_to do |format|
      if @friend.save
        format.html do
          redirect_to friend_url(@friend), alert: { message: 'Friend was successfully created.', type: 'success' }
        end
        format.json { render :show, status: :created, location: @friend }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @friend.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /friends/1 or /friends/1.json
  def update
    respond_to do |format|
      if @friend.update(friend_params)
        format.html do
          redirect_to friend_url(@friend), alert: { message: 'Friend was successfully updated.', type: 'warning' }
        end
        format.json { render :show, status: :ok, location: @friend }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @friend.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /friends/1 or /friends/1.json
  def destroy
    @friend.destroy!

    respond_to do |format|
      format.html { redirect_to friends_url, alert: { message: 'Friend was successfully deleted.', type: 'danger' } }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_friend
    @friend = Friend.find(params[:id])
  end

  def sort_friends
    @friends = @friends.order("#{params[:sort_by]} #{params[:sort_direction]}") if params[:sort_by].present?
  end

  def filter_friends
    return unless params[:search].present?

    search_term = params[:search].downcase
    @friends = @friends.select do |friend|
      friend.name.downcase.include?(search_term) ||
        friend.email.downcase.include?(search_term) ||
        friend.phone.downcase.include?(search_term)
    end
  end

  # Only allow a list of trusted parameters through.
  def friend_params
    params.require(:friend).permit(:name, :email, :phone).merge(user: current_user)
  end
end
