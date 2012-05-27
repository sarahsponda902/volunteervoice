class FlagsController < ApplicationController
  # GET /flags
  # GET /flags.json
  def index
    @flags = Flag.all.reverse

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @flags }
    end
  end

  # GET /flags/1
  # GET /flags/1.json
  def show
    @flag = Flag.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @flag }
    end
  end

  # GET /flags/new
  # GET /flags/new.json
  def new
    @flag = Flag.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @flag }
    end
  end

  # POST /flags
  # POST /flags.json
  def create
    @flag = Flag.new(params[:flag])
    @flag.truncated200 = RedCloth.new( ActionController::Base.helpers.sanitize( (@flag.body[0..199] + "...") ), [:filter_html, :filter_styles, :filter_classes, :filter_ids] ).to_html
    @flag.body = RedCloth.new( ActionController::Base.helpers.sanitize( @flag.body ), [:filter_html, :filter_styles, :filter_classes, :filter_ids] ).to_html
    respond_to do |format|
      if @flag.save
        format.html { redirect_to @flag, notice: 'Flag was successfully created.' }
        format.json { render json: @flag, status: :created, location: @flag }
      else
        format.html { render action: "new" }
        format.json { render json: @flag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /flags/1
  # DELETE /flags/1.json
  def destroy
    @flag = Flag.find(params[:id])
    @flag.destroy

    respond_to do |format|
      format.html { redirect_to flags_url }
      format.json { head :no_content }
    end
  end
end
