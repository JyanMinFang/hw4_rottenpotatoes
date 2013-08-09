require 'spec_helper'

describe MoviesController do
  describe 'find similar movies by the director' do
    it 'should call the model method that performs TMDb search' do
      get :similar
    end
    it 'should select the Search Results template for rendering'
    it 'should make the TMDb search results available to that template'
  end
end
