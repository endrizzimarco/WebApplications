require "application_system_test_case"

class MoviesTest < ApplicationSystemTestCase
  setup do
    @movie = movies(:one)
  end

  test "visiting the index" do
    visit movies_url
    assert_selector "h1", text: "Movies"
  end

  test "creating a Movie" do
    visit movies_url
    click_on "New Movie"

    fill_in "Casts", with: @movie.casts
    fill_in "Genres", with: @movie.genres
    fill_in "Img path", with: @movie.img_path
    fill_in "Rating", with: @movie.vote.average
    fill_in "Release date", with: @movie.release_date
    fill_in "Runtime", with: @movie.runtime
    fill_in "Synopsis", with: @movie.synopsis
    fill_in "Title", with: @movie.title
    fill_in "tagline", with: @movie.tagline
    fill_in "user_rating", with: @movie.user_rating
    fill_in "api_id", with: @movie.api_id
    fill_in "user_id", with: @movie.user_id
    click_on "Create Movie"

    assert_text "Movie was successfully created"
    click_on "Back"
  end

  test "updating a Movie" do
    visit movies_url
    click_on "Edit", match: :first

    fill_in "Casts", with: @movie.casts
    fill_in "Genres", with: @movie.genres
    fill_in "Img path", with: @movie.img_path
    fill_in "Rating", with: @movie.vote_average
    fill_in "Release date", with: @movie.release_date
    fill_in "Runtime", with: @movie.runtime
    fill_in "Synopsis", with: @movie.synopsis
    fill_in "Title", with: @movie.title
    fill_in "tagline", with: @movie.tagline
    fill_in "user_rating", with: @movie.user_rating
    fill_in "api_id", with: @movie.api_id
    fill_in "user_id", with: @movie.user_id
    click_on "Update Movie"

    assert_text "Movie was successfully updated"
    click_on "Back"
  end

  test "destroying a Movie" do
    visit movies_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Movie was successfully destroyed"
  end
end
