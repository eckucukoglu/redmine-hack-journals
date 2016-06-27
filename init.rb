Redmine::Plugin.register :hackjournals do
  name 'Hackjournals plugin'
  url ''
  description 'Hack issue journal details'
  author 'Emre Can Kucukoglu'
  author_url 'http://eckucukoglu.com'
  version '0.0.1'
  requires_redmine version_or_higher: '2.5.2'

  menu :admin_menu, :hackjournals, { :controller => 'hackjournals', :action => 'index' }, :caption => 'HackJournals'

  settings({
     :partial => 'settings/settings',
     :default => {
       'label' => 'HackJournals'
      }
  })

end
