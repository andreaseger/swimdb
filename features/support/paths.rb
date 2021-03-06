module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /the home\s?page/
      '/'
    when /the list of (.+)/
      "/#{$1}"
    when /the schedule page/
      schedule_path(Schedule.last)
      #"/schedules/#{Schedule.last.id.to_s}"
    when /the edit schedule page/
      edit_schedule_path(Schedule.last)
      #"/schedules/#{Schedule.last.id.to_s}/edit"
    when /userlogin/
      new_user_session_path
      #"/users/sign_in"
    when /the new comment page/
      schedule_comments_path(Schedule.last)
    when /the admin area/
      adminarea_users_path
    when /adminlogin/
      new_admin_session_path
      #new_schedule_comment_path(Schedule.last)
    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /the (.*) page/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue Object => e
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)

