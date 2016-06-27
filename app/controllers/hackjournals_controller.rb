class HackjournalsController < ApplicationController
  unloadable
  before_filter :require_admin

  def index
  end

  def show_journals
    @issue = Issue.find(params[:hackjournals][:issue_id])
    if @issue != nil
      @journals = Journal.find_all_by_journalized_id(@issue.id)


    end
  end

  private
  def require_admin
    if User.current.admin == true
      return true
    else
      redirect_to :action => :index, :controller => 'projects'
      flash[:error] = "You are not autharized."
      return false
    end
  end




end
