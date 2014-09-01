module EspeoMembersDates
  class Hooks < Redmine::Hook::ViewListener

    # Add members.starts_on and members.ends_on fields to project/settings/_members table.
    # 
    # Available context variables:
    # :project => Project
    def view_projects_settings_members_table_header(context = {})
      context[:controller].send(:render_to_string, {
        :partial => "projects/settings/members_dates_th",
        :locals => context
      })
    end


    # Add members.starts_on and members.ends_on fields to project/settings/_members table.
    # 
    # Available context variables:
    # :project => Project
    # :member => Member
    def view_projects_settings_members_table_row(context = {})
      context[:controller].send(:render_to_string, {
        :partial => "projects/settings/members_dates_td",
        :locals => context
      })
    end
  end
end
