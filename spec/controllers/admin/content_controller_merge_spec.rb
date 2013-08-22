 require 'spec_helper'

describe Admin::ContentController do
   render_views
   describe 'merge action' do 
     before :each do
       @blog = Factory(:blog)
       @article = Factory(:article, :body => 'a first article')
       @second_article = Factory(:article, :body => 'a second article')
     end
     it 'will ask an article to merge itself with another (stubbed unit test)' do
        @article.should_receive(:merge_with).with(@second_article.id)
       put :merge, {:merge_id => @second_article.id}
     end
     it 'will redirect to the edit form of the first article' do
       pending "I don't know how to authenticate in here"
       put :merge, {:merge_id => @second_article.id}
       response.should redirect_to ('admin/content/edit/' + @article.id.to_s)
     end
     it 'will redirect to the dashboard article index' do
       pending "I don't know how to authenticate in here"
       put :merge, {:merge_id => @second_article.id}
       response.should redirect_to ('admin/content')
     end
   end
 end
    
