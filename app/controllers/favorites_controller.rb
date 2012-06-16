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
    @program_id = @favorite.program_id
    @favorite.destroy
    
    respond_to do |format|
      if params[:the_place].class.name != "Integer"
        format.html { redirect_to "/pages/profile" }
      else
        format.html { redirect_to "/programs/#{@program_id}}" }
      end
      format.json { head :no_content }
    end
  end
end
