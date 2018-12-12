# frozen_string_literal: true

# rubocop:disable Metrics/LineLength
RSpec.shared_context 'Typhoeus responses' do
  let(:base_url) { 'http://www.example.com' }

  let(:example_request) do
    Etna::Components::Request.new.build(url: 'http://www.example.com', method: :get)
  end

  let(:valid_auth_response) do
    Typhoeus::Response.new({
      httpauth_avail: 0,
      total_time: 0.205744,
      starttransfer_time: 0.205318,
      appconnect_time: 0.079701,
      pretransfer_time: 0.079814,
      connect_time: 0.021757,
      namelookup_time: 0.005249,
      redirect_time: 0.0,
      effective_url: 'https://api.solaris-testing.de/oauth/token?grant_type=client_credentials',
      primary_ip: '10.4.7.231',
      response_code: 201,
      request_size: 449,
      redirect_count: 0,
      return_code: :ok,
      body: '{"access_token":"3a1o7h2532b7g4lros6qcpo8kpojnffjxdol5samuqmys6j42hqmyx3q2xfke4b3ekopy9","token_type":"Bearer","expires_in":5939}',
      response_headers: "HTTP/1.1 201 Created\r\nCache-Control: no-store\r\nContent-Length: 129\r\nContent-Type: application/json\r\nPragma: no-cache\r\nX-Content-Type-Options: nosniff\r\nX-Request-Id: 2665bd96-a136-11e8-ba4b-02420a86e003\r\nDate: Thu, 16 Aug 2018 09:24:18 GMT",
    })
  end

  let(:unauthorized_auth_response) do
    Typhoeus::Response.new({
      httpauth_avail: 0,
      total_time: 0.24226899999999996,
      starttransfer_time: 0.241742,
      appconnect_time: 0.079123,
      pretransfer_time: 0.079227,
      connect_time: 0.022036,
      namelookup_time: 0.005232,
      redirect_time: 0.0,
      effective_url: 'https://api.solaris-testing.de/oauth/token?grant_type=client_credentials',
      primary_ip: '10.4.7.231',
      response_code: 401,
      request_size: 388,
      redirect_count: 0,
      return_code: :ok,
      response_body: '{"errors":[{"id":"267b3a74-a136-11e8-ba4b-02420a86e003","status":401,"code":"invalid_client","title":"Invalid Client","detail":"Client is invalid"}]}',
      response_headers: "HTTP/1.1 401 Unauthorized\r\nContent-Length: 149\r\nContent-Type: application/json\r\nX-Content-Type-Options: nosniff\r\nX-Request-Id: 267b3a74-a136-11e8-ba4b-02420a86e003\r\nDate: Thu, 16 Aug 2018 09:24:18 GMT",
    })
  end

  let(:non_valid_api_response) do
    Typhoeus::Response.new({
      httpauth_avail: 0,
      total_time: 0.094215,
      starttransfer_time: 0.094058,
      appconnect_time: 0.076362,
      pretransfer_time: 0.076434,
      connect_time: 0.020792,
      namelookup_time: 0.005238,
      redirect_time: 0.0,
      effective_url: 'https://api.solaris-testing.de/oauth/tokenpoken?grant_type=client_credentials',
      primary_ip: '10.4.7.231',
      response_code: 404,
      request_size: 393,
      redirect_count: 0,
      return_code: :ok,
      response_headers: "HTTP/1.1 404 Not Found\r\nX-Request-Id: 5a409cff-a13c-11e8-ba4b-02420a86e003\r\nDate: Thu, 16 Aug 2018 10:08:41 GMT\r\nContent-Length: 0\r\n\r\n",
      response_body: '',
    })
  end

  let(:timed_out_response) do
    Typhoeus::Response.new({
      httpauth_avail: 0,
      total_time: 0.018632,
      starttransfer_time: 0.0,
      appconnect_time: 0.0,
      pretransfer_time: 0.0,
      connect_time: 0.0,
      namelookup_time: 0.005125,
      redirect_time: 0.0,
      effective_url: 'http://www.example.com/',
      primary_ip: '',
      response_code: 0,
      request_size: 0,
      redirect_count: 0,
      return_code: :operation_timedout,
      response_headers: '',
      response_body: '',
    })
  end

  let(:valid_collection_response) do
    Typhoeus::Response.new({
      httpauth_avail: 0,
      total_time: 0.235031,
      starttransfer_time: 0.234197,
      appconnect_time: 0.08243,
      pretransfer_time: 0.082533,
      connect_time: 0.021822,
      namelookup_time: 0.005324,
      redirect_time: 0.0,
      effective_url: 'https://api.solaris-testing.de/v1/businesses',
      primary_ip: '10.4.7.231',
      response_code: 200,
      request_size: 262,
      redirect_count: 0,
      return_code: :ok,
      response_headers: "HTTP/1.1 200 OK\r\nContent-Length: 7967\r\nContent-Type: application/json\r\nLink: <api.solaris-testing.de/v1/businesses?page%5Bnumber%5D=1&page%5Bsize%5D=10>; rel=\"first\",<api.solaris-testing.de/v1/businesses?page%5Bnumber%5D=449&page%5Bsize%5D=10>; rel=\"last\",<api.solaris-testing.de/v1/businesses?page%5Bnumber%5D=2&page%5Bsize%5D=10>; rel=\"next\"\r\nPer-Page: 10\r\nSortable-Columns: name\r\nTotal: 20\r\nX-Content-Type-Options: nosniff\r\nX-Request-Id: a024d2d8-a13f-11e8-ba4b-02420a86e003\r\nDate: Thu, 16 Aug 2018 10:32:07 GMT\r\n\r\n",
      response_body: '[{"id":"ca48a28d5d5dbc271c8bbae4955efb05cbiz","name":"Example GmbH","sector":"OTHER_COMPANIES","industry":"OTHER_SERVICES","industry_key":"EDUCATION","address":{"line_1":"Address 1","line_2":"Address 2","postal_code":"10409","city":"Berlin","country":"DE","state":"BE"},"legal_form":"GMBH","foundation_date":"1990-06-01","tax_information":{"tax_country":"DE","tax_confirmation":"SINGLE","registration_number":"HRB 12345","registration_issuer":"Amtsgericht Berlin"},"fatca_relevant":true,"fatca_crs_confirmed_at":"2017-01-01T00:00:00.000Z","crs_company_type":"FE_REPORTING","business_purpose":"change the world for the better","terms_conditions_signed_at":"2017-01-01T00:00:00.000Z","flagged_by_compliance":false,"balance_sheet_total":null,"number_employees":null,"registration_type":null},{"id":"0ef82e1ee6fb21f2dff067ad7de98379cbiz","name":"tba3a6d65b6d179756bb5145e1d1fe974","sector":"OTHER_COMPANIES","industry":"OTHER_SERVICES","industry_key":"EDUCATION","address":{"line_1":"Address 1","line_2":"Address 2","postal_code":"10409","city":"Cologne","country":"DE","state":"BE"},"legal_form":"GMBH","foundation_date":"1990-06-01","tax_information":{"tax_country":"DE","tax_confirmation":"SINGLE","registration_number":"HRB 12345","registration_issuer":"Amtsgericht Berlin"},"fatca_relevant":true,"fatca_crs_confirmed_at":"2017-01-01T00:00:00.000Z","crs_company_type":"FE_REPORTING","business_purpose":"change the world for the better","terms_conditions_signed_at":"2017-01-01T00:00:00.000Z","flagged_by_compliance":false,"balance_sheet_total":null,"number_employees":null,"registration_type":null},{"id":"c7ecfb423a80d7abd8f00ed76a74051dcbiz","name":"tbf827d2f876d000e1be10d3adb523467","sector":"OTHER_COMPANIES","industry":"OTHER_SERVICES","industry_key":"EDUCATION","address":{"line_1":"Address 1","line_2":"Address 2","postal_code":"10409","city":"Berlin","country":"DE","state":"BE"},"legal_form":"GMBH","foundation_date":"1990-06-01","tax_information":{"tax_country":"DE","tax_confirmation":"SINGLE","registration_number":"HRB 12345","registration_issuer":"Amtsgericht Berlin"},"fatca_relevant":true,"fatca_crs_confirmed_at":"2017-01-01T00:00:00.000Z","crs_company_type":"FE_REPORTING","business_purpose":"change the world for the better","terms_conditions_signed_at":"2017-01-01T00:00:00.000Z","flagged_by_compliance":false,"balance_sheet_total":null,"number_employees":null,"registration_type":null},{"id":"62e1d9c99bae83217c86d89437a2bbf6cbiz","name":"Example GmbH","sector":"OTHER_COMPANIES","industry":"OTHER_SERVICES","industry_key":"EDUCATION","address":{"line_1":"Address 1","line_2":"Address 2","postal_code":"10409","city":"Berlin","country":"DE","state":"BE"},"legal_form":"GMBH","foundation_date":"1990-06-01","tax_information":{"tax_country":"DE","tax_confirmation":"SINGLE","registration_number":"HRB 12345","registration_issuer":"Amtsgericht Berlin"},"fatca_relevant":true,"fatca_crs_confirmed_at":"2017-01-01T00:00:00.000Z","crs_company_type":"FE_REPORTING","business_purpose":"change the world for the better","terms_conditions_signed_at":"2017-01-01T00:00:00.000Z","flagged_by_compliance":false,"balance_sheet_total":null,"number_employees":null,"registration_type":null},{"id":"5086df44553a0c64e6732934d4cae850cbiz","name":"Example GmbH","sector":"OTHER_COMPANIES","industry":"OTHER_SERVICES","industry_key":"EDUCATION","address":{"line_1":"Address 1","line_2":"Address 2","postal_code":"10409","city":"Berlin","country":"DE","state":"BE"},"legal_form":"GMBH","foundation_date":"1990-06-01","tax_information":{"tax_country":"DE","tax_confirmation":"SINGLE","registration_number":"HRB 12345","registration_issuer":"Amtsgericht Berlin"},"fatca_relevant":true,"fatca_crs_confirmed_at":"2017-01-01T00:00:00.000Z","crs_company_type":"FE_REPORTING","business_purpose":"change the world for the better","terms_conditions_signed_at":"2017-01-01T00:00:00.000Z","flagged_by_compliance":false,"balance_sheet_total":null,"number_employees":null,"registration_type":null},{"id":"0251a9ba916ae11ee5323004fd18e744cbiz","name":"Example GmbH","sector":"OTHER_COMPANIES","industry":"OTHER_SERVICES","industry_key":"EDUCATION","address":{"line_1":"Address 1","line_2":"Address 2","postal_code":"10409","city":"Berlin","country":"DE","state":"BE"},"legal_form":"GMBH","foundation_date":"1990-06-01","tax_information":{"tax_country":"DE","tax_confirmation":"SINGLE","registration_number":"HRB 12345","registration_issuer":"Amtsgericht Berlin"},"fatca_relevant":true,"fatca_crs_confirmed_at":"2017-01-01T00:00:00.000Z","crs_company_type":"FE_REPORTING","business_purpose":"change the world for the better","terms_conditions_signed_at":"2017-01-01T00:00:00.000Z","flagged_by_compliance":false,"balance_sheet_total":null,"number_employees":null,"registration_type":null},{"id":"04071d94d6517c6d027eba6b033757bdcbiz","name":"t9716cb4ceb910cc2af9154badd161127","sector":"OTHER_COMPANIES","industry":"OTHER_SERVICES","industry_key":"EDUCATION","address":{"line_1":"Address 1","line_2":"Address 2","postal_code":"10409","city":"Cologne","country":"DE","state":"BE"},"legal_form":"GMBH","foundation_date":"1990-06-01","tax_information":{"tax_country":"DE","tax_confirmation":"SINGLE","registration_number":"HRB 12345","registration_issuer":"Amtsgericht Berlin"},"fatca_relevant":true,"fatca_crs_confirmed_at":"2017-01-01T00:00:00.000Z","crs_company_type":"FE_REPORTING","business_purpose":"change the world for the better","terms_conditions_signed_at":"2017-01-01T00:00:00.000Z","flagged_by_compliance":false,"balance_sheet_total":null,"number_employees":null,"registration_type":null},{"id":"f80919b41be7d13dd3d6a06332d52b2acbiz","name":"tfea16d4fb504f0119ee088898d17fb37","sector":"OTHER_COMPANIES","industry":"OTHER_SERVICES","industry_key":"EDUCATION","address":{"line_1":"Address 1","line_2":"Address 2","postal_code":"10409","city":"Berlin","country":"DE","state":"BE"},"legal_form":"GMBH","foundation_date":"1990-06-01","tax_information":{"tax_country":"DE","tax_confirmation":"SINGLE","registration_number":"HRB 12345","registration_issuer":"Amtsgericht Berlin"},"fatca_relevant":true,"fatca_crs_confirmed_at":"2017-01-01T00:00:00.000Z","crs_company_type":"FE_REPORTING","business_purpose":"change the world for the better","terms_conditions_signed_at":"2017-01-01T00:00:00.000Z","flagged_by_compliance":false,"balance_sheet_total":null,"number_employees":null,"registration_type":null},{"id":"7a76bf02dfc127de91bc8d9222c8fd91cbiz","name":"Example GmbH","sector":"OTHER_COMPANIES","industry":"OTHER_SERVICES","industry_key":"EDUCATION","address":{"line_1":"Address 1","line_2":"Address 2","postal_code":"10409","city":"Berlin","country":"DE","state":"BE"},"legal_form":"GMBH","foundation_date":"1990-06-01","tax_information":{"tax_country":"IT","tax_confirmation":"SINGLE","registration_number":"HRB 12345","registration_issuer":"Amtsgericht Berlin"},"fatca_relevant":true,"fatca_crs_confirmed_at":"2017-01-01T00:00:00.000Z","crs_company_type":"FE_REPORTING","business_purpose":"change the world for the better","terms_conditions_signed_at":"2017-01-01T00:00:00.000Z","flagged_by_compliance":false,"balance_sheet_total":null,"number_employees":null,"registration_type":null},{"id":"eb280095c478b31b05ddec2a8a7bea58cbiz","name":"Example GmbH","sector":"OTHER_COMPANIES","industry":"OTHER_SERVICES","industry_key":"EDUCATION","address":{"line_1":"Address 1","line_2":"Address 2","postal_code":"10409","city":"Berlin","country":"DE","state":"BE"},"legal_form":"GMBH","foundation_date":"1990-06-01","tax_information":{"tax_country":"DE","tax_confirmation":"SINGLE","registration_number":"HRB 12345","registration_issuer":"Amtsgericht Berlin"},"fatca_relevant":true,"fatca_crs_confirmed_at":"2017-01-01T00:00:00.000Z","crs_company_type":"FE_REPORTING","business_purpose":"change the world for the better","terms_conditions_signed_at":"2017-01-01T00:00:00.000Z","flagged_by_compliance":false,"balance_sheet_total":null,"number_employees":null,"registration_type":null}]',
    })
  end

  let(:valid_entity_response) do
    Typhoeus::Response.new({
      httpauth_avail: 0,
      total_time: 0.051783,
      starttransfer_time: 0.051606,
      appconnect_time: 7.3e-05,
      pretransfer_time: 0.000155,
      connect_time: 7.3e-05,
      namelookup_time: 7.2e-05,
      redirect_time: 0.0,
      effective_url: 'https://api.solaris-testing.de/v1/businesses/ca48a28d5d5dbc271c8bbae4955efb05cbiz',
      primary_ip: '10.4.7.231',
      response_code: 200,
      request_size: 299,
      redirect_count: 0,
      return_code: :ok,
      response_headers: "HTTP/1.1 200 OK\r\nContent-Length: 787\r\nContent-Type: application/json\r\nX-Content-Type-Options: nosniff\r\nX-Request-Id: 9611f38e-a153-11e8-8d7b-02420a86d40f\r\nDate: Thu, 16 Aug 2018 12:55:00 GMT\r\n\r\n",
      response_body: '{"id":"ca48a28d5d5dbc271c8bbae4955efb05cbiz","name":"Example GmbH","sector":"OTHER_COMPANIES","industry":"OTHER_SERVICES","industry_key":"EDUCATION","address":{"line_1":"Address 1","line_2":"Address 2","postal_code":"10409","city":"Berlin","country":"DE","state":"BE"},"legal_form":"GMBH","foundation_date":"1990-06-01","tax_information":{"tax_country":"DE","tax_confirmation":"SINGLE","registration_number":"HRB 12345","registration_issuer":"Amtsgericht Berlin"},"fatca_relevant":true,"fatca_crs_confirmed_at":"2017-01-01T00:00:00.000Z","crs_company_type":"FE_REPORTING","business_purpose":"change the world for the better","terms_conditions_signed_at":"2017-01-01T00:00:00.000Z","flagged_by_compliance":false,"balance_sheet_total":null,"number_employees":null,"registration_type":null}',
    })
  end

  let(:invalid_json_response) do
    Typhoeus::Response.new({
      httpauth_avail: 0,
      total_time: 0.051783,
      starttransfer_time: 0.051606,
      appconnect_time: 7.3e-05,
      pretransfer_time: 0.000155,
      connect_time: 7.3e-05,
      namelookup_time: 7.2e-05,
      redirect_time: 0.0,
      effective_url: 'https://api.solaris-testing.de/v1/businesses/ca48a28d5d5dbc271c8bbae4955efb05cbiz',
      primary_ip: '10.4.7.231',
      response_code: 200,
      request_size: 299,
      redirect_count: 0,
      return_code: :ok,
      response_headers: "HTTP/1.1 200 OK\r\nContent-Length: 787\r\nContent-Type: application/json\r\nX-Content-Type-Options: nosniff\r\nX-Request-Id: 9611f38e-a153-11e8-8d7b-02420a86d40f\r\nDate: Thu, 16 Aug 2018 12:55:00 GMT\r\n\r\n",
      response_body: '{"id:ca48a28d5d5dbc271c8bbae4955efb05cbiz""name":"Example GmbH","sector":"OTHER_COMPANIES","industry":"OTHER_SERVICES","industry_key":"EDUCATION","address":{"line_1":"Address 1","line_2":"Address 2","postal_code":"10409","city":"Berlin","country":"DE","state":"BE"},"legal_form":"GMBH","foundation_date":"1990-06-01","tax_information":{"tax_country":"DE","tax_confirmation":"SINGLE","registration_number":"HRB 12345","registration_issuer":"Amtsgericht Berlin"},"fatca_relevant":true,"fatca_crs_confirmed_at":"2017-01-01T00:00:00.000Z","crs_company_type":"FE_REPORTING","business_purpose":"change the world for the better","terms_conditions_signed_at":"2017-01-01T00:00:00.000Z","flagged_by_compliance":false,"balance_sheet_total":null,"number_employees":null,"registration_type":null}',
    })
  end
end
# rubocop:enable Metrics/LineLength
