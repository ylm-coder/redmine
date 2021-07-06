Redmine::Plugin.register :projets_manager do
  name 'Projets Manager plugin'
  author 'Anıl Yılmaz'
  description 'This is a plugin for homework'
  version '0.0.1'
  permission :project_manager, { manager: [:index] }, public: true
  menu :project_menu, :project_manager, { controller: 'manager', action: 'index' },
       caption: 'Project Manager',
       after: :activity,
       param: :project_id
  project_module :project_manager do
    permission :manage, {
      :manager => :index
    }
  end    
end
