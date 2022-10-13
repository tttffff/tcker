class TeamsController < ApplicationController
  before_action :set_team, only: %i[ show edit update destroy ]

  def index
    @teams = policy_scope(Team).ordered
  end

  def show
    authorize @team 
  end

  def new
    @team = Team.new
    authorize @team
  end

  def edit
    authorize @team
  end

  def create
    @team = Team.new(team_params)
    authorize @team

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
    authorize @team
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
    authorize @team
    @team.destroy

    respond_to do |format|
      format.html { redirect_to teams_url, notice: "Team was successfully removed." }
      format.turbo_stream { flash.now[:notice] = "Team was successfully removed." }
    end
  end

  private
    def set_team
      @team = policy_scope(Team).find(params[:id])
    end

    def team_params
      params.require(:team).permit(:name)
    end
end
