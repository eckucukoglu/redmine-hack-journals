
get 'hackjournals', :to => 'hackjournals#index', as: 'hackjournals'

post 'hackjournals/journals', :to => 'hackjournals#show_journals', as: 'show_journals'
get 'hackjournals/journals/:id/edit', :to => 'hackjournals#edit_journal', as: 'edit_journal'
delete 'hackjournals/journals/:id/', :to => 'hackjournals#destroy_journal', as: 'destroy_journal'
