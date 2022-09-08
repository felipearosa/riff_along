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
    @video = Video.find(params[:catalog][:video]) if params[:catalog][:video] != ''
    unless @video
      video_id = CGI.escape(params[:catalog][:video_id])
      url = "https://youtube.googleapis.com/youtube/v3/videos?part=snippet&id=#{video_id}&key=#{ENV.fetch('YOUTUBE_API')}"
      videos_serialized = URI.open(url).read
      videos_info = JSON.parse(videos_serialized)["items"][0]
      video_title = videos_info["snippet"]["title"]
      video_image_url = videos_info["snippet"]["thumbnails"]["medium"]["url"]
      @video = Video.new(title: video_title, image_url: video_image_url, youtube_key: video_id)
      @video.save!
    end
    @catalog = Catalog.new
    @catalog.video = @video
    if @list_id == ""
      redirect_to user_video_path(user_id: current_user, id: @video.youtube_key)
    else
      @catalog.list = List.find(@list_id)
      authorize @catalog
      if @catalog.save!
        if params[:solos]
          @test = []
          @solos = params[:solos]
          @solos.each do |_key, arr|
            arr = arr.split(',').map { |word| word.strip }
            next if arr.length == 4
            @solo = Solo.new(starting_time: arr[0], ending_time: arr[1])
            @solo.done = arr[2] == 'mastered'
            @solo.video = @video
            @solo.save!
          end
        end
        redirect_to user_video_path(user_id: current_user, id: @video.youtube_key)
      end
    end
  end

  def destroy
    @catalog = Catalog.find(params[:id])
    authorize @catalog
    @catalog.destroy
    redirect_to list_path(@catalog.list), status: :see_other
  end
end
