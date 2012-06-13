class FavoritesController < ApplicationController

  
  # POST /favorites
  # POST /favorites.json
  def create
    @favorite = Favorite.new(params[:favorite])
    @favorite.program_id = params[:program_id]
    @favorite.user_id = current_user.id
    @favorite.save
    respond_to do |format|
      format.html { redirect_to Program.find(@favorite.program_id), notice: 'Added to favorites' }
    end
  end


  # DELETE /favorites/1
  # DELETE /favorites/1.json
  def destroy
    @favorite = Favorite.find(params[:id])
    @favorite.destroy
    redirect_to "/#{params[:field]}/#{params[:location]}"
  end
end
