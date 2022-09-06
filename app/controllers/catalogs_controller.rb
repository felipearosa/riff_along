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
    @video.save!
    if params[:solos]
      @test = []
      @solos = params[:solos]
      @solos.each do |_key, arr|
        arr = arr.split(',')
        @solo = Solo.new(starting_time: arr[0], ending_time: arr[1])
        @solo.video = @video
        @solo.save!
      end
    end
    @catalog = Catalog.new
    @catalog.video = @video
    @catalog.list = List.find(@list_id)
    if @video.save && @catalog.save
      redirect_to user_video_path(user_id: current_user, id: @video.youtube_key)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @catalog = Catalog.find(params[:id])
    @catalog.destroy
    redirect_to list_path(@catalog.list), status: :see_other
  end
end
