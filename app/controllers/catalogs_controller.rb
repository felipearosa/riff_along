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
    @video = Video.find(params[:catalog][:video])
    @catalog = Catalog.new
    @catalog.video = @video
    if @list_id == ""
      redirect_to user_video_path(user_id: current_user, id: @video.youtube_key)
    else
      @catalog.list = List.find(@list_id)
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
    @catalog.destroy
    redirect_to list_path(@catalog.list), status: :see_other
  end
end
