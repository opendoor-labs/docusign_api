require 'minitest/autorun'
require 'mocha/mini_test'

require 'webmock'
require 'webmock/minitest'
include WebMock::API

DOCUSIGN_ACCOUNT_BASE_URL = 'https://demo.docusign.net/restapi/v2/accounts/1234567'.freeze
DOCUSIGN_LOGIN_URL = 'https://demo.docusign.net/restapi/v2/login_information'.freeze
DOCUSIGN_DEFAULT_HEADERS = {
  'Accept'=>'application/json',
  'Content-Type'=>'application/json',
  'X-Docusign-Authentication' => \
    %r|<DocuSignCredentials>.*<Username>.+</Username>.*<Password>.+</Password>.*<IntegratorKey>.+</IntegratorKey>.*</DocuSignCredentials>|m
}.freeze

def stub_docusign_login
  stub_request(:get, DOCUSIGN_LOGIN_URL).
    with(headers: DOCUSIGN_DEFAULT_HEADERS).
    to_return(status: 200, body: File.read('test/data/login_information.json'))
end
