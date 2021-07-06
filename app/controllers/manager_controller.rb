class ManagerController < ApplicationController
  def index
    @project = Project.find(params[:project_id])

      @changes = []
      @project.issues.each do |issue|
        issue.time_entries.each do |te|
          @changes << {
            change_type: 'time',
            issue: issue,
            time: te.created_on,
            user: te.user,
            hours: te.hours,
            activity: te.activity
          }
        end
        issue.journals.each do |je|
          je.details.each do |detail|
            field_name = detail.prop_key.delete_suffix('_id')
            @changes << {
              change_type: 'property',
              issue: issue,
              time: je.created_on,
              user: je.user,
              field: field_name,
              from: "issue_#{field_name}".classify.constantize.find_by(id: detail.old_value),
              to: "issue_#{field_name}".classify.constantize.find_by(id: detail.value),
            }
          end
        end
      end
      @changes = if params[:order] == 'issue_id'
                   @changes.sort_by { |change| change[:issue] }
                 else
                   @changes.sort_by { |change| change[:time] }.reverse
                 end
  end
end
