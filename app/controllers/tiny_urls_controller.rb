class TinyUrlsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_tiny_url, only: [:show, :edit, :update, :destroy]
  layout "tiny_url"
  include CodeDecodeUrlModule

  # method to show home view
  def home
    @tiny_url = TinyUrl.new
  end

  # method to generate short url by decoding id
  def get_tiny_url
    @tiny_url = TinyUrl.new
    begin
      @full_url = ''
      original_url = tiny_url_params[:orginal_url]
      @tiny_url.orginal_url = original_url
      @tiny_url.system_info = request.remote_ip

      #TODO this code can be imroved
      if @tiny_url.save!
        short_url = genrate_short_url(@tiny_url.id)
        base_url = get_base_url
        @tiny_url.generated_url = short_url
        @tiny_url.save!
        @full_url = base_url+'/'+short_url
      end
      respond_to do |format|
        format.json{
          render :json => {tiny_url: @full_url, status: 'success', status_code: 200}
        }
        format.js{}
      end
    rescue Exception => e
      respond_to do |format|
        format.json{
          render :json => {error: e, status: 'error'}
        }
        format.js{}
      end
    end
  end

  #method to orginal url by decoding code to id
  def get_orginal_url
    begin
      decoded_url = get_decoded_url
      url_id = get_url_id(decoded_url)
      @tiny_url = TinyUrl.find(url_id)
      redirect_to @tiny_url.orginal_url
    rescue Exception => e
      flash[:danger] = "Url not found"
      redirect_to home_path
    end

  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_tiny_url
    @tiny_url = TinyUrl.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def tiny_url_params
    params.require(:tiny_url).permit(:orginal_url)
  end
end
