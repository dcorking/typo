require 'spec_helper'

describe 'article merge functionality' do
  before do
    Factory(:blog)
  end
  before :each do
    @article = Factory(:article, :body => 'a first article')
    @second_article = Factory(:article, :body => 'a second article')
  end
  context 'for admins' do
    before do
      @user = Factory(:user, :login => "jdoe", :password => "secret", :profile => Factory(:profile_admin, :label => Profile::ADMIN))
      post '/accounts/login', :user => {"login" => "jdoe", "password" => "secret"}
    end
    it 'will redirect to a display of the first article (integration)' do
      put "/admin/content/merge/#{@article.id}", {:merge_with => @second_article.id}
      follow_redirect!
      expect(response.body).to match /a first articlea second article/
    end
  end
end
