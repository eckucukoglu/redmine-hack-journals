get 'hackjournals', :to => 'hackjournals#index', as: 'hackjournals'
get 'hackjournals/journals', :to => 'hackjournals#show', as: 'show_hackjournals'
get 'hackjournals/:issue_id/journals', :to => 'hackjournals#show_journals', as: 'show_journals'

get 'hackjournals/:issue_id/journals/:id/edit', :to => 'hackjournals#edit_journal', as: 'edit_issue_journal'
delete 'hackjournals/:issue_id/journals/:id/', :to => 'hackjournals#destroy_journal', as: 'destroy_issue_journal'

put 'hackjournals/:issue_id/journals/:id/', :to => 'hackjournals#update_journal', as: 'update_journal'
put 'hackjournals/:issue_id/journals/:journal_id/details/:id', :to => 'hackjournals#update_journal_details', as: 'update_journal_details'
