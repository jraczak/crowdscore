require 'spec_helper'

describe AdminHelper do
  it "generates a current subnav item" do
    params[:controller] = "admin/users"
    html = helper.admin_subnav_item("Users", "/admin/users", "admin/users")
    html.should == '<li class="active"><a href="/admin/users">Users</a></li>'
  end

  it "generates a subnav item" do
    params[:controller] = "admin/dashboards"
    html = helper.admin_subnav_item("Users", "/admin/users", "admin/users")
    html.should == '<li><a href="/admin/users">Users</a></li>'
  end
end
