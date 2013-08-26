require 'spec_helper'

describe "admin/content/new.html.erb" do
  before do
    admin = stub_model(User, :settings => {:editor => 'simple'}, :admin? => true,
                       :text_filter_name => "", :profile_label => "admin")
    blog = mock_model(Blog, :base_url => "http://myblog.net/")
    article = stub_model(Article).as_new_record
    text_filter = stub_model(TextFilter)

    article.stub(:text_filter) { text_filter }
    view.stub(:current_user) { admin }
    view.stub(:this_blog) { blog }

    # FIXME: Nasty. Controller should pass in @categories and @textfilters.
    Category.stub(:all) { [] }
    TextFilter.stub(:all) { [text_filter] }

    assign :article, article
  end

  it "renders with no resources or macros" do
    assign(:images, [])
    assign(:macros, [])
    assign(:resources, [])
    render
  end

  it "renders with image resources" do
    # FIXME: Nasty. Thumbnail creation should not be controlled by the view.
    img = mock_model(Resource, :filename => "foo", :create_thumbnail => nil)
    assign(:images, [img])
    assign(:macros, [])
    assign(:resources, [])
    render
  end

  describe "article merge form" do
    it "isn't rendered to a non-admin" do
      pending 'not yet coded in app'
      #FIXME I don't think this should be the view's responsibility
      #TODO factor the next line out, as it is common to most of these tests
      assign(:macros, []); assign(:resources, []); assign(:images, [])
      # assign a non-admin user
      publisher = stub_model(User, :settings => {:editor => 'simple'}, :admin? => false,
                             :text_filter_name => "", :profile_label => "publisher")
      view.stub(:current_user) { publisher }
      render
      rendered.should_not contain 'Article ID'
      rendered.should_not contain 'Merge Articles'
    end

    it "must show the article merge form to an admin on edit (unit test)" do
      assign(:macros, []); assign(:resources, []); assign(:images, [])
      article = stub_model(Article, :id => 6) 
      # article exists so it is being edited
      @_action_name = 'edit' # FIXME this line smells like the spec is in the wrong place 
      stub_template "admin/shared/_merge.html.erb" => "Merge Articles Stub<br />"
      render
      rendered.should contain 'Merge Articles Stub'
    end

    it "must not show the article merge to an admin on new (unit test)" do
      assign(:macros, []); assign(:resources, []); assign(:images, [])
      # article is new
      stub_template "admin/shared/_merge.html.erb" => "Merge Articles Stub<br />"
      render
      rendered.should_not contain 'Merge Articles'
    end

    it "will, for article edits, show two forms (functional test)" do
      assign(:macros, []); assign(:resources, []); assign(:images, [])
      # article exists so it is being edited
      @_action_name = 'edit' # FIXME this line smells like the spec is in the wrong place 
      render
      assert_select "form", 2
    end

    it "will, for article edits, use the put method in the merge form (functional test)" do
      assign(:macros, []); assign(:resources, []); assign(:images, [])
      # article exists so it is being edited
      @_action_name = 'edit' # FIXME this line smells like the spec is in the wrong place 
      render
      forms = css_select('form') # should be 2 forms, second will be merge form
      merge_form_text = forms[1].select('input')[1].to_s
      merge_form_text.should match /.*method.*put.*/
      # or try this funky alternative
      # assert forms[1].match(:descendant => {:tag => 'input', :attributes => {:name => '_method'}})
    end

    it "will, for article edits, have an Article ID label in the merge form (functional test)" do
      assign(:macros, []); assign(:resources, []); assign(:images, [])
      # article exists so it is being edited
      @_action_name = 'edit' # FIXME this line smells like the spec is in the wrong place 
      render
      forms = css_select('form') # should be 2 forms, second will be merge form
      # should this label be for 'merge_id' or 'merge_with' ?
      forms[1].should match(:descendant => {:tag => 'label', :attributes => {:for => 'merge_id'}, :child => /Article ID/ })
    end

    it "will, for article edits, show a merge form with a text field for the article to 'merge_with' (functional test)" do
      assign(:macros, []); assign(:resources, []); assign(:images, [])
      # article exists so it is being edited
      @_action_name = 'edit' # FIXME this line smells like the spec is in the wrong place 
      render
      forms = css_select('form') # should be 2 forms, second will be merge form
      forms[1].should match(:descendant => {:tag => 'input', :attributes => {:type => 'text', :name => 'merge_with'}})
    end

    it "will, for article edits, have a button captioned 'Merge' to submit a merge form (functional test)" do
      assign(:macros, []); assign(:resources, []); assign(:images, [])
      # article exists so it is being edited
      @_action_name = 'edit' # FIXME this line smells like the spec is in the wrong place 
      render
      forms = css_select('form') # should be 2 forms, second will be merge form
      forms[1].should match(:descendant => {:tag => 'input', :attributes => {:type => 'submit', :value => 'Merge'}})
    end

    it "will, for article edits, have a button captioned 'Merge' to submit a merge form (functional test)" do
      assign(:macros, []); assign(:resources, []); assign(:images, [])
      # article exists so it is being edited
      @_action_name = 'edit' # FIXME this line smells like the spec is in the wrong place 
      render
      forms = css_select('form') # should be 2 forms, second will be merge form
      forms[1].should match(:descendant => {:tag => 'input', :attributes => {:type => 'submit', :value => 'Merge'}})
    end

    it "will link to the merge action for the current article" do
      pending %Q{this causes
     Failure/Error: render
     ActionView::Template::Error:
       No route matches {:controller=>"admin/test", :action=>"destroy", :id=>1005}
     # ./app/helpers/admin/base_helper.rb:51:in `link_to_destroy_with_profiles'
     # ./app/views/admin/content/_form.html.erb:12:in `_app_views_admin_content__form_html_erb__104610851_105449690_144272186'}
 
      assign(:macros, []); assign(:resources, []); assign(:images, [])
      # article exists so it is being edited
      assign(:_action_name, 'edit') 
      article = stub_model(Article)
      assign(:article, article)
      debugger
      render
      render :partial => 'admin/shared/merge'
      assert_select("form[action=/admin/content/merge/#{article.id}]") 
    end
  end
end
