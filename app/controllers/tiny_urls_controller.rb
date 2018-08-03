class TinyUrlsController < ApplicationController
  skip_before_action :verify_authenticity_token
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
      if @tiny_url.save!
        base_url = get_base_url
        @full_url = base_url+'/'+@tiny_url.generated_url
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
      path_after_base_url = request.original_fullpath
      @tiny_url = TinyUrl.get_tiny_url_by_path(path_after_base_url)
      redirect_to @tiny_url.orginal_url
    rescue Exception => e
      flash[:danger] = "Somthing wrong! Url not found"
      redirect_to home_path
    end

  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def tiny_url_params
    params.require(:tiny_url).permit(:orginal_url)
  end
end
