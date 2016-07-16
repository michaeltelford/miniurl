require 'urls_helper'

class UrlsController < ApplicationController
  include UrlsHelper
  
  def index
    @urls = Url.all
  end
  
  def show
    @url = Url.find(params[:id])
  end
  
  def new
    @url = Url.new
  end
  
  def create
    @url = Url.find_by(external: url_params[:external])
    if not @url
      @url = Url.new(url_params)
      if not @url.save
        render 'new' and return
      end
    end
    redirect_to @url
  end
  
  def redirect
    url = Url.find_by(internal: params[:internal_url])
    if not url
      flash.notice = "The Mini Url wasn't recognized."
      redirect_to action: "new" and return
    end
    redirect_to url.external, status: :found
  end
  
private
  
  def url_params
    params.require(:url).permit(:external)
  end
end
