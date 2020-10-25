class SearchesController < ApplicationController
  def search
    results = Searcher.call(params[:query])
    redirect_to result_path(results: results, query: params[:query])
  end

  def result
    @query = params[:query]
    @results = params[:results]
  end
end
