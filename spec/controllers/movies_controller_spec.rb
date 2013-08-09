require 'spec_helper'

describe MoviesController do
  describe 'find similar movies by the director' do
    it 'should route to the similar movie route' do
      { :get => '/movies/1/similar' }.should route_to(
       :controller => 'movies', :action => 'similar', :id => '1')
    end
    it 'should find the similar movies by director' do
      fake_movie1 = mock('Movie', :id => 1, :director => 'George Lucas', :title => 'Star Wars')
      fake_movie4 = mock('Movie', :id => 4, :director => 'George Lucas', :title => 'THX-1138')
      fake_movies = [fake_movie1, fake_movie4]
      Movie.should_receive(:find).with(fake_movie1.id.to_s).and_return(fake_movie1)
      Movie.should_receive(:find_all_by_director).with(fake_movie1.director).and_return(fake_movies)
      get :similar, {:id => '1'}
    end
    it 'should select the Similiar Movies template for rendering' do
      fake_movie1 = mock('Movie', :id => 1, :director => 'George Lucas', :title => 'Star Wars')
      fake_movie4 = mock('Movie', :id => 4, :director => 'George Lucas', :title => 'THX-1138')
      fake_movies = [fake_movie1, fake_movie4]
      Movie.should_receive(:find).with(fake_movie1.id.to_s).and_return(fake_movie1)
      Movie.should_receive(:find_all_by_director).with(fake_movie1.director).and_return(fake_movies)
      get :similar, {:id => "1"}
      assigns(:movie).should == fake_movie1
      assigns(:movies).should == fake_movies
      response.should render_template('similar')
    end
    it 'should be on the home page with no director info' do
      fake_movie = mock('Movie', :id => 3, :title => 'Alien', :director => nil)
      Movie.should_receive(:find).with(fake_movie.id.to_s).and_return(fake_movie)
      get :similar, {:id => "3"}
      flash[:notice].should == "'#{fake_movie.title}' has no director info"
      assigns(:movie).should == fake_movie
      response.should redirect_to(:action => 'index')
    end
  end
end
