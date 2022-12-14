require 'json'
require 'rest-client'

class VideosController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @videos = policy_scope(Video)
    @videos = []
    if params[:query].present?
      query = CGI.escape(params[:query])
      url = "https://youtube.googleapis.com/youtube/v3/search?part=snippet&maxResults=10&order=relevance&q=#{query}&key=#{ENV.fetch('YOUTUBE_API')}"
    else
      url = "https://youtube.googleapis.com/youtube/v3/search?part=snippet&maxResults=10&order=relevance&q=Jimi+Hendrix+songs&key=#{ENV.fetch('YOUTUBE_API')}"
    end
    loop_videos_search(url)
  end

  def show
    @solo = Solo.new
    @achievements = Achievement.all
    @list = List.new
    @params = params[:id]
    @catalog = Catalog.new
    if params[:user_id]
      @user = User.find(params[:user_id])
      @video = @user.videos.where(youtube_key: @params).last
      @video_id = @video.id
      @video_title = @video.title

      # @video_id = @video.id
      # Needs refactoring
      if @user.videos.where(youtube_key: @params).last
        unless @user.videos.where(youtube_key: @params).last.solos.empty?
          @solos = @user.videos.where(youtube_key: @params).last.solos.order(:starting_time)
        end
      end
    else
      @video = current_user&.videos&.find_by(youtube_key: @params)
      if @video.present?
        redirect_to user_video_path(user_id: current_user.id, id: @params)
      else
        @video = Video.new(youtube_key: @params)
      end
    end
    authorize @video
  end

  def update
    @video = Video.find(params[:id])
    authorize @video
    @solos = params[:solos]
    if @solos
      @solos.each do |_key, arr|
        arr = arr.split(',').map { |word| word.strip }
        next if arr.length == 4
        @solo = Solo.new(starting_time: arr[0], ending_time: arr[1])
        @solo.done = arr[2] == 'mastered'
        @solo.video = @video
        @solo.save!
      end
      achievements = Achievement.all
      achievements.each do |achievement|
        unless current_user.achievements.include?(achievement)
          next if current_user.solos.where(done: true).length < achievement.count
          current_user.achievements << achievement
        end
      end
    end
    redirect_to user_video_path(user_id: current_user, id: @solo.video.youtube_key), status: :see_other if @solo
  end

  def destroy
    @video = Video.find(params[:id])
    authorize @video
    @video.destroy
    redirect_to videos_path, status: :see_other
  end

  private

  def loop_videos_search(url)
    videos_serialized = RestClient.get url
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
