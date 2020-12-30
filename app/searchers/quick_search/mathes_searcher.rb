module QuickSearch
  class MathesSearcher < QuickSearch::Searcher
    
    def search
      @http.ssl_config.verify_mode=(OpenSSL::SSL::VERIFY_NONE)
      resp = @http.get(base_url, parameters.to_query)
      @response = JSON.parse(resp.body)
    end

    def results
      if results_list
        results_list

      else
        @results_list = []

        #@match_fields = ['title_ssm', '']

        @response['data'].each do |value|
          result = OpenStruct.new
          #result.title = value['title']['attributes']['value']
          result.title = value['attributes']['title_tesim']['attributes']['value']
          result.author = value['attributes']['author_ssim']['attributes']['value']
          result.link = value['links']['self']
          result.date = value['attributes']['display_date_tesim']['attributes']['value']
          #if value.key?('description')
            #result.author = value['description'][0]
          #end
          if value['attributes'].key?('file')
            result.thumbnail = URI::join(value['attributes']['file']['attributes']['value'], "?file=thumbnail").to_s
          end
          #if value.key?('collection_tesim')
            #result.collection = [value['collection_tesim'][0], collection_builder(value['collection_number_tesim'][0]).to_s]
          #end
          result.description = value['attributes']['description']['attributes']['value']

          @results_list << result
        end

        @results_list
      end

    end

    def base_url
      "https://archives.albany.edu/mathes/catalog"
    end

    def parameters
      {
        'search_field' => 'all_fields',
        'q' => http_request_queries['not_escaped'],
        'utf8' => true,
        'per_page' => @per_page,
        'format' => 'json'
      }
    end

    def collection_builder(uri)
      collection_link = URI::join(base_url, +"/mathes/catalog/" + uri.tr(".", "-"))

      collection_link
    end

    def total
      @response['meta']['pages']['total_count'].to_i
    end

    def loaded_link
      "https://archives.albany.edu/mathes?search_field=all_fields&q=" + http_request_queries['not_escaped']
    end

  end
end
