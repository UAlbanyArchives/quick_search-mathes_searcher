module QuickSearch
  module MathesSearcher
    class Engine < ::Rails::Engine
      isolate_namespace QuickSearch::MathesSearcher
    end
  end
end
