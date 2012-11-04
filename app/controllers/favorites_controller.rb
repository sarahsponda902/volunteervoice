class FavoritesController < ApplicationController
  include ActionView::Helpers::TextHelper
  before_filter :authenticate_user!

  # POST /favorites
  # POST /favorites.json
  def create
    @favorite = Favorite.new(params[:favorite])
    @favorite.program_id = params[:program_id]
    @favorite.user_id = current_user.id
    @favorite.save #will never be invalid, so no 'if' statement needed
    respond_to do |format|
      format.html { redirect_to Program.find(@favorite.program_id), notice: 'Added to favorites' }
    end
  end


  # DELETE /favorites/1
  # DELETE /favorites/1.json
  def destroy
    @favorite = Favorite.find(params[:id])
    @program_id = @favorite.program_id
    @favorite.destroy

    respond_to do |format|
      ## the_place is a parameter passed to instruct where the user should be redirected after unfavoriting
      #### if the_place is an integer, the 'destroy' was called from the program profile page
      #### if the_place is a string, the 'destroy' was called from the user's profile page

      if params[:the_place].class.name != "Integer"
        format.html { redirect_to "/pages/profile/favorite_deleted" }
      else
        format.html { redirect_to Program.find(@program_id) }
      end
      format.json { head :no_content }
    end
  end
end
