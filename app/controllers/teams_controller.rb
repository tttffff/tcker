class TeamsController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    respond_to do |format|
      if @team.save
        current_user.add_role :team_owner, @team
        format.html { redirect_to teams_url, notice: "Team was successfully created." }
        format.turbo_stream { flash.now[:notice] = "Team was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to teams_url, notice: "Team was successfully updated." }
        format.turbo_stream { flash.now[:notice] = "Team was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @team.destroy

    respond_to do |format|
      format.html { redirect_to teams_url, notice: "Team was successfully removed." }
      format.turbo_stream { flash.now[:notice] = "Team was successfully removed." }
    end
  end

  private
    def team_params
      params.require(:team).permit(:name)
    end
end
