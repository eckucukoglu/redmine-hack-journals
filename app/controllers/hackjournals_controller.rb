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
    @journals = Journal.where(journalized_id: @issue.id)
  end

  def edit_journal
    @issue = Issue.find(params[:issue_id])
    @journal = Journal.find(params[:id])
    @jdetails = JournalDetail.where(journal_id: params[:id])

    @project_users = Project.find(@issue.project_id).users

    @options = Array.new
    @selectedoption = @journal.user_id

    @project_users.each do |user|
      @options.push([user.firstname, user.id])
    end

  end

  def update_journal
    @journal = Journal.find(params[:id])

    @year = params[:journal]["created_on(1i)"].to_i
    @month = params[:journal]["created_on(2i)"].to_i
    @day = params[:journal]["created_on(3i)"].to_i
    @hour = params[:journal]["created_on(4i)"].to_i
    @minute = params[:journal]["created_on(5i)"].to_i
    @datetime = DateTime.new(@year, @month, @day, @hour, @minute)

    if @journal.update_attributes(:notes => params[:journal][:notes], :created_on => @datetime, :user_id => params[:journal][:user_id])
      flash[:success] = "Journal updated."
      redirect_to show_journals_path(:issue_id => params[:issue_id])
    else
      flash.now[:alert] = "Journal couldn't be updated! Please check the form."
      render edit_issue_journal_path(:issue_id => params[:issue_id], :id => params[:id])
    end
  end

  def update_journal_details
    @jdetail = JournalDetail.find(params[:id])

    if @jdetail.update_attributes(:property => params[:jdetail][:property], :prop_key => params[:jdetail][:prop_key],
                                  :old_value => params[:jdetail][:old_value], :value => params[:jdetail][:value])
      flash[:success] = "Journal detail updated."
      redirect_to show_journals_path(:issue_id => params[:issue_id])
    else
      flash.now[:alert] = "Journal detail couldn't be updated! Please check the form."
      render edit_issue_journal_path(:issue_id => params[:issue_id], :id => params[:id])
    end
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
