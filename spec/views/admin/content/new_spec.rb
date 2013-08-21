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

  it "doesn't render the article merge form to a non-admin" do
    #FIXME this passes when the feature isn't implemented
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

  it "must show the article merge form to an admin on edit" do
    assign(:macros, []); assign(:resources, []); assign(:images, [])
    old_article = stub_model(Article, :id => 6)
    pending
    # rendering this causes a routing error
    # seems to route like this:
    #    No route matches {:controller=>"admin/test", :action=>"destroy", :id=>6}
    # render
    # rendered.should contain 'Article ID'
    # rendered.should contain 'Merge Articles'
    #TODO stub out partial 'admin/content/merge'
  end

  it "must not show the article merge to an admin on new" do
    assign(:macros, []); assign(:resources, []); assign(:images, [])
    render
    rendered.should_not contain 'Article ID'
    rendered.should_not contain 'Merge Articles'
  end
end
