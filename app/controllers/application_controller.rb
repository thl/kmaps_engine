# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  uses_tiny_mce :options => { 
  								:theme => 'advanced',
  								:editor_selector => 'mceEditor2',
  								:width => '550px',
  								:height => '220px',
  								:theme_advanced_resizing => 'true',
  								:theme_advanced_toolbar_location => 'top', 
  								:theme_advanced_toolbar_align => 'left',
  								:theme_advanced_buttons1 => %w{fullscreen separator bold italic underline strikethrough separator undo redo separator link unlink template formatselect code},
  								:theme_advanced_buttons2 => %w{cut copy paste separator pastetext pasteword separator bullist numlist outdent indent separator  justifyleft justifycenter justifyright justifiyfull separator removeformat  charmap },
  								:theme_advanced_buttons3 => [],
  								:plugins => %w{contextmenu paste media fullscreen template noneditable },				
  								:template_external_list_url => '/templates/templates.js',
  								:noneditable_leave_contenteditable => 'true',
  								:theme_advanced_blockformats => 'p,h1,h2,h3,h4,h5,h6'
  								}
  # helper :all include all helpers, all the time

  include Spelling

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '051292610481c0699540df094adf0f36'  
  
  def spellchecker 
      language, words, method = params[:params][0], params[:params][1], params[:method] unless params[:params].blank?
      return render :nothing => true if language.blank? || words.blank? || method.blank?
      headers["Content-Type"] = "text/plain"
      headers["charset"] = "utf-8"
      suggestions = check_spelling(words, method, language)
      results = {"id" => nil, "result" => suggestions, "error" => nil}
      render :json => results
  end
  
end