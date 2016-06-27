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

# <Journal id: 1, journalized_id: 28, journalized_type: "Issue", user_id: 1, notes: "asdadasd", created_on: "2016-06-27 07:22:49", private_notes: false>
# <JournalDetail id: 1, journal_id: 2, property: "attr", prop_key: "done_ratio", old_value: "1000", value: "40"> 

  def edit_journal
  end

  def destroy_journal
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
