class SearchesController < ApplicationController
  include ActionView::Helpers::TextHelper

  # GET /searchs/new
  # GET /searchs/new.json
  def new
    @search = Search.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @search }
    end
  end

  # POST /searchs
  # POST /searchs.json
  def create
    @search = Search.new(params[:search])
    respond_to do |format|
      if @search.save
        format.html { redirect_to @search }
        format.json { render json: @search, status: :created, location: @search }
      else
        format.html { render action: "new" }
        format.json { render json: @search.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /searchs/1
  # DELETE /searchs/1.json
  def destroy
    @search = Search.find(params[:id])
    @search.destroy

    respond_to do |format|
      format.html { redirect_to "/searches/program_search" }
      format.json { head :no_content }
    end
  end
  
  def program_search
  end
    
end