class SolosController < ApplicationController

  # def new
  #   @solo = Solo.new
  #   # authorize @solo
  # end

  def update
      @solo = Solo.find(params[:id])
      if @solo.done
        @solo.done = false
      else
        @solo.done = true
      end

      if @solo.save
        achievements = Achievement.all
        achievements.each do |achievement|
          unless current_user.achievements.include?(achievement)
            next if current_user.solos.where(done: true).length < achievement.count
            current_user.achievements << achievement
          end
        end
      else
        render 'videos/show', status: :unprocessable_entity
      end
  end

  def destroy
    @solo = Solo.find(params[:id])
    @solo.destroy

    redirect_to user_video_path(user_id: current_user, id: @solo.video.youtube_key), status: :see_other
  end
end
