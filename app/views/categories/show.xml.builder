xml.instruct!
xml << render(:partial => 'show.xml.builder', :locals => {:category => category, :with_children => with_children, :only_with_features => only_with_features})