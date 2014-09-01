# Unfortunately, currently MembersController doesn't have any hooks in #update and #create methods.
# 
# Thus, we have to replace them, just to:
# - add support for #starts_on and #ends_on attributes
module EspeoMembersDates::Patches::MembersControllerPatch
  def self.included(base)
    base.extend         ClassMethods
    base.send :include, InstanceMethods

    base.class_eval do
      alias_method_chain :create, :dates
      alias_method_chain :update, :dates
    end
  end

  module ClassMethods
  end
  
  module InstanceMethods
    def create_with_dates
      members = []
      if params[:membership]
        if params[:membership][:user_ids]
          attrs = params[:membership].dup
          user_ids = attrs.delete(:user_ids)
          user_ids.each do |user_id|
            members << Member.new(:role_ids => params[:membership][:role_ids], :user_id => user_id)
          end
        else
          members << Member.new(:role_ids => params[:membership][:role_ids], :user_id => params[:membership][:user_id])
        end
        # START ESPEO TWEAK
        members.each do |member|
          member.starts_on = params[:membership][:starts_on]
          member.ends_on = params[:membership][:ends_on]
        end
        # END ESPEO TWEAK
        @project.members << members
      end

      respond_to do |format|
        format.html { redirect_to_settings_in_projects }
        format.js { @members = members }
        format.api {
          @member = members.first
          if @member.valid?
            render :action => 'show', :status => :created, :location => membership_url(@member)
          else
            render_validation_errors(@member)
          end
        }
      end
    end

    def update_with_dates
      if params[:membership]
        @member.role_ids = params[:membership][:role_ids]
        # START ESPEO TWEAK
        @member.starts_on = params[:membership][:starts_on]
        @member.ends_on = params[:membership][:ends_on]
        # END ESPEO TWEAK
      end
      saved = @member.save
      respond_to do |format|
        format.html { redirect_to_settings_in_projects }
        format.js
        format.api {
          if saved
            render_api_ok
          else
            render_validation_errors(@member)
          end
        }
      end
    end
  end
end

Rails.application.config.to_prepare do
  MembersController.send :include, EspeoMembersDates::Patches::MembersControllerPatch
end
