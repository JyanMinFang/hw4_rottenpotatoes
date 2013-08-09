Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
  Movie.create(movie)
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
  end
end

When /^(?:|I )go to the edit page for "(.+)"$/ do |title|
  editMovie = Movie.where({title: title}).first
  visit path_to('in the edit page for ' + editMovie._id.to_s)
end

Then /^the director of "(.+)" should be "(.+)"$/ do |title,director|
    if page.respond_to? :should
      page.should have_content(title)
      assert page.has_content?(director)
    else
      page.should have_content(title)
      assert page.has_content?(director)
    end

end

Given /^(?:|I )am on the details page for "(.+)"$/ do |title|
  thisMovie = Movie.where({title: title}).first
  visit path_to('in the detail page for ' + thisMovie._id.to_s)
end

When /^(?:|I )follow "Find Movies With Same Director"$/ do
  movieId = current_path[current_path.rindex('/') + 1]
  visit path_to('similar movies by director for ' + movieId)
end

Then /^(?:|I )should be on the Similar Movies page for "(.+)"$/ do |title|
    if page.respond_to? :should
      page.should have_content(title)
    else
      page.should have_content(title)
    end
end

Then /^(?:|I )should be on the home page$/ do
    if page.respond_to? :should
      page.should have_content("All Movies")
    else
      page.should have_content("All Movies")
    end 
end
