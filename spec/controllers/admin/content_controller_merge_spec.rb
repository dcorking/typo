 require 'spec_helper'

describe Admin::ContentController do
   render_views
   describe 'merge action' do 
     before do
       Factory(:blog)
       @user = Factory(:user, :profile => Factory(:profile_admin, :label => Profile::ADMIN))
       request.session = { :user => @user.id }
     end
     before :each do
       @article = Factory(:article, :body => 'a first article')
       @second_article = Factory(:article, :body => 'a second article')
     end
     it 'will ask an article to merge itself with another (stubbed unit test)' do
       Article.any_instance.should_receive(:merge_with).with(@second_article.id)
       put :merge, {:id => @article.id, :merge_id => @second_article.id}
     end
     it 'will redirect to the edit form of the first article' do
       Article.any_instance.stub(:merge_with)
       put :merge, {:id => @article.id, :merge_id => @second_article.id}
       response.should redirect_to ('/admin/content/edit/' + @article.id.to_s)
     end
   end
 end
    
