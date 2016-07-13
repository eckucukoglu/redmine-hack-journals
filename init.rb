Redmine::Plugin.register :hackjournals do
  name 'Hackjournals plugin'
  url 'https://github.com/eckucukoglu/redmine-hack-journals'
  description 'Hack issue journal details'
  author 'Emre Can Kucukoglu'
  author_url 'http://eckucukoglu.com'
  version '0.0.2'

  menu :admin_menu, :hackjournals, { :controller => 'hackjournals', :action => 'index' }, :caption => 'HackJournals'

  settings({
     :partial => 'settings/settings',
     :default => {
       'label' => 'HackJournals'
      }
  })

end
