
get 'hackjournals', :to => 'hackjournals#index', as: 'hackjournals'

post 'hackjournals/journals', :to => 'hackjournals#show_journals', as: 'show_journals'
