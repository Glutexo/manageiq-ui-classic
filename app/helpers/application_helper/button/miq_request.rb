class ApplicationHelper::Button::MiqRequest < ApplicationHelper::Button::GenericFeatureButton
  needs :@record, :@request_tab

  def role_allows_feature?
    prefix = case @request_tab
             when 'ae', 'host'
               "#{@request_tab}_"
             else
               ""
             end
    # check RBAC on separate button
    role_allows?(:feature => "#{prefix}#{@feature}")
  end

  def visible?
    return false if @record.resource_type == "AutomationRequest" &&
                   !%w(miq_request_approval miq_request_deny miq_request_delete).include?(@feature)
    true
  end
end
