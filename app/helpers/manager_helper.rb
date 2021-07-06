module ManagerHelper
  def render_change_for(change)
    if change[:change_type] == 'time'
      # render partial: "manager/time_entry", locals: {change: change}
      "#{change[:time]} - #{change[:user].name} has been worked on \"#{change[:issue].subject}\" issue for #{change[:hours]} hours."
    else
      event = change[:from] ? 'changed' : 'set'
      "#{change[:time]} - #{change[:user].name} has been #{event} #{change[:field]} #{event == 'changed' ? 'from' : 'to'}
      #{event == 'changed' ? "#{change[:from]} to #{change[:to]}" : change[:to]} for \"#{change[:issue].subject}\" issue."
    end
  end
end
