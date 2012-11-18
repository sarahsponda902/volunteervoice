class FavoritesController < ApplicationController
  include ActionView::Helpers::TextHelper
  before_filter :authenticate_user!
  respond_to :html, :json

  # POST /favorites
  # POST /favorites.json
  def create
    @favorite = Favorite.new(params[:favorite])
    @favorite.program_id = params[:program_id]
    @favorite.user_id = current_user.id
    flash[:notice] = "Added to favorites" if @favorite.save 
    respond_with(@favorite) do
      redirect_to Program.find(@favorite.program_id)
    end
  end


  # DELETE /favorites/1
  # DELETE /favorites/1.json
  def destroy
    @favorite = Favorite.find(params[:id])
    @program_id = @favorite.program_id
    @favorite.destroy

    respond_with(@favorite) do
      if params[:the_place].is_a?(Integer)
        redirect_to Program.find(@program_id)
      else
        redirect_to "/pages/profile/favorite_deleted"
      end
    end
  end
end
