require 'open-uri'
require 'json'

class VideosController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @videos = []
    if params[:query].present?
      query = CGI.escape(params[:query])
      url = "https://youtube.googleapis.com/youtube/v3/search?part=snippet&maxResults=10&order=relevance&q=#{query}&key=#{ENV.fetch('YOUTUBE_API')}"
    else
      url = "https://youtube.googleapis.com/youtube/v3/search?part=snippet&maxResults=10&order=relevance&q=Jimi+Hendrix&key=#{ENV.fetch('YOUTUBE_API')}"
    end
    loop_videos_search(url)
  end

  def show
    # @solo = Solo.new
    @params = params[:id]
    # @video = Video.new
    @catalog = Catalog.new
    @list = List.new
    if params[:user_id]
      @user = User.find(params[:user_id])
      @video = @user.videos.where(youtube_key: @params).last
      # Needs refactoring
      unless @user.videos.where(youtube_key: @params).last.solos.empty?
        @solos = @user.videos.where(youtube_key: @params).last.solos
      end
    end
  end

  def create
    redirect_to root_path
  end

  def update
    @video = Video.find(params[:id])
    @solos = params[:solos]
    @solos.each do |_key, arr|
      arr = arr.split(',')
      next if arr.length == 3
      @solo = Solo.new(starting_time: arr[0], ending_time: arr[1])
      @solo.video = @video
      @solo.save!
    end
    if @solo
      redirect_to user_video_path(user_id: current_user, id: @solo.video.youtube_key), status: :see_other
    end


  def destroy
    @video = Video.find(params[:id])
    @video.destroy
    redirect_to videos_path, status: :see_other
  end

  private

  def loop_videos_search(url)
    videos_serialized = URI.open(url).read
    videos_info = JSON.parse(videos_serialized)["items"]

    videos_info.each do |video|
      video_final = {}
      video_final[:title] = CGI.unescapeHTML(video["snippet"]["title"])
      video_final[:video_id] = video["id"]["videoId"]
      video_final[:image_url_high] = video["snippet"]["thumbnails"]["high"]["url"]
      video_final[:image_url_medium] = video["snippet"]["thumbnails"]["medium"]["url"]
      @videos << video_final if video["id"]["kind"] == "youtube#video"
    end
  end

end
