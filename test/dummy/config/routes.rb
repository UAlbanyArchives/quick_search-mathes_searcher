Rails.application.routes.draw do
  mount QuickSearch::MathesSearcher::Engine => "/quick_search-mathes_searcher"
end
