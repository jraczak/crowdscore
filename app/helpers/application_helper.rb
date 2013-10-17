# -*- coding: utf-8 -*-

module ApplicationHelper
  # Public: Generates a resource's error messages as a sentence, wrapped in an
  # alert message.
  #
  # resource - An ActiveModel-compliant object
  #
  # Examples
  #
  #   errors_for(@user) # When user is valid
  #   # => ""
  #
  #   errors_for(@user) # When user is invalid and has one error
  #   # => '<div class="alert-message error"><p>Name can\'t be blank</p></div>'
  #
  #   errors_for(@user) # When user is invalid and has two errors
  #   # => '<div class="alert-message error"><p>Name can\'t be blank and Email can\'t be blank</p></div>'
  #
  #   errors_for(@user) # When user is invalid and has three errors
  #   # => '<div class="alert-message error"><p>Name can\'t be blank, Email can\'t be blank, and birthday can't be blank</p></div>'
  #
  # Returns a SafeBuffer string containing an error sentence.
  def errors_for(resource)
    return "" if resource.errors.empty?

    messages = resource.errors.full_messages.to_sentence
    flash_message(:error, messages).html_safe
  end

  # Public: generates alert messages from all flash notices and alerts. Note
  # that flash message types are converted to the relevant class for Twitter
  # Bootstrap.
  #
  # Examples:
  #
  #   flash_messages # when no flash messages exist in alert or notice
  #   # => ''
  #
  #   flash_messages # when flash messages exist in alert
  #   # => '<div class="alert-message error"><p>Name can\'t be blank</p></div>'
  #
  #   flash_messages # when flash messages exist in notice
  #   # => '<div class="alert-message info"><p>User was successfully created.</p></div>'
  #
  #   flash_messages # when flash messages exist in alert and notice
  #   # => '<div class="alert-message info"><p>User was successfully created.</p></div><div class="alert-message error"><p>Name can\'t be blank</p></div>'
  #
  # Returns a SafeBuffer string containing the alert messages
  def flash_messages
    type_mappings = { :notice => "info", :alert => "error" }

    [:notice, :alert].inject("") do |str, type|
      str << flash_message(type_mappings[type], flash[type]) if flash[type].present?
      str
    end.html_safe
  end

  # Interpolates a message type and message into a common HTML format.
  #
  # Examples:
  #
  #   flash_messages(:error, "You suck")
  #   # => "<div class=\"alert-message error\"><p>You suck</p></div>"
  #
  # Returns a SafeBuffer string of the flash message HTML.
  def flash_message(type, message)
    "<div class=\"alert-message #{type}\"><p>#{message}</p></div>".html_safe
  end

  def paginate(collection)
    will_paginate collection, renderer: WillPaginate::ActionView::TwitterBootstrapLinkRenderer
  end
  
  # Support references for supplying Devise forms in application-wide modals
  
  def resource_name
    :user
  end

  def devise_resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
  
end
