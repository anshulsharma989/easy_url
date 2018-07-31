class TinyUrlsController < ApplicationController
  before_action :set_tiny_url, only: [:show, :edit, :update, :destroy]

  # GET /tiny_urls
  # GET /tiny_urls.json
  def index
    @tiny_urls = TinyUrl.all
  end

  # GET /tiny_urls/1
  # GET /tiny_urls/1.json
  def show
  end

  # GET /tiny_urls/new
  def new
    @tiny_url = TinyUrl.new
  end

  # GET /tiny_urls/1/edit
  def edit
  end

  # POST /tiny_urls
  # POST /tiny_urls.json
  def create
    @tiny_url = TinyUrl.new(tiny_url_params)

    respond_to do |format|
      if @tiny_url.save
        format.html { redirect_to @tiny_url, notice: 'Tiny url was successfully created.' }
        format.json { render :show, status: :created, location: @tiny_url }
      else
        format.html { render :new }
        format.json { render json: @tiny_url.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tiny_urls/1
  # PATCH/PUT /tiny_urls/1.json
  def update
    respond_to do |format|
      if @tiny_url.update(tiny_url_params)
        format.html { redirect_to @tiny_url, notice: 'Tiny url was successfully updated.' }
        format.json { render :show, status: :ok, location: @tiny_url }
      else
        format.html { render :edit }
        format.json { render json: @tiny_url.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tiny_urls/1
  # DELETE /tiny_urls/1.json
  def destroy
    @tiny_url.destroy
    respond_to do |format|
      format.html { redirect_to tiny_urls_url, notice: 'Tiny url was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tiny_url
      @tiny_url = TinyUrl.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tiny_url_params
      params.fetch(:tiny_url, {})
    end
end
