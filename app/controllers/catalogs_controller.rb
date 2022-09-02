require 'open-uri'
require 'json'

class CatalogsController < ApplicationController
  def new
    @catalog = Catalog.new
  end

  def index
  end

  def create
    @list_id = params[:catalog][:list_id]
    video_id = CGI.escape(params[:catalog][:video_id])
    url = "https://youtube.googleapis.com/youtube/v3/videos?part=snippet&id=#{video_id}&key=#{ENV.fetch('YOUTUBE_API')}"
    videos_serialized = URI.open(url).read
    videos_info = JSON.parse(videos_serialized)["items"][0]

    video_title = videos_info["snippet"]["title"]
    video_image_url = videos_info["snippet"]["thumbnails"]["medium"]["url"]
    @video = Video.new(title: video_title, image_url: video_image_url, youtube_key: video_id)
    @video.save
    @catalog = Catalog.new
    @catalog.video = @video
    @catalog.list = List.find(@list_id)

    if @video.save && @catalog.save
      redirect_to video_path(video_id)
    else
      render :new, status: :unprocessable_entity
    end
  end
end
