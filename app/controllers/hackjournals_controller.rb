class HackjournalsController < ApplicationController
  unloadable
  before_filter :require_admin

  def index

  end

  def show
    @issueExist = Issue.exists?(id: params[:hackjournals][:issue_id])
    if @issueExist
      redirect_to show_journals_path(issue_id: params[:hackjournals][:issue_id])
    else
      flash.now[:alert] = "Issue id not exist."
      render hackjournals_path
    end
  end

  def show_journals
    @issue = Issue.find(params[:issue_id])
    @journals = Journal.find_all_by_journalized_id(@issue.id)
  end

  def edit_journal
    @issue = Issue.find(params[:issue_id])
    @journal = Journal.find(params[:id])
    @jdetails = JournalDetail.find_all_by_journal_id(params[:id])
  end

  def update_journal
    @journal = Journal.find(params[:id])

    @year = params[:journal]["created_on(1i)"].to_i
    @month = params[:journal]["created_on(2i)"].to_i
    @day = params[:journal]["created_on(3i)"].to_i
    @hour = params[:journal]["created_on(4i)"].to_i
    @minute = params[:journal]["created_on(5i)"].to_i
    @datetime = DateTime.new(@year, @month, @day, @hour, @minute)

    if @journal.update_attributes(:notes => params[:journal][:notes], :created_on => @datetime)
      flash[:success] = "Journal updated."
      redirect_to show_journals_path(:issue_id => params[:issue_id])
    else
      flash.now[:alert] = "Journal couldn't be updated! Please check the form."
      render edit_journal_path(:issue_id => params[:issue_id], :id => params[:id])
    end
  end

  def update_journal_details

  end

  def destroy_journal
    @journal = Journal.find(params[:id])

    if @journal.destroy
      flash[:success] = "Journal deleted."
      redirect_to show_journals_path(@journal.journalized_id)
    else
      flash.now[:alert] = "Journal couldn't be deleted!"
      render show_journals_path(@journal.journalized_id)
    end
  end

  private
  def require_admin
    if User.current.admin == true
      return true
    else
      redirect_to :action => :index, :controller => 'projects'
      flash[:error] = "You are not authorized."
      return false
    end
  end


end
