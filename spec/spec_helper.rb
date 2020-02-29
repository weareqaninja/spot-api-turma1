require_relative "services/api"
require_relative "libs/mongo"

ambiente = ENV["AMBIENTE"]
CONFIG = YAML.load_file(File.join(Dir.pwd, "./spec/env/#{ambiente}.yaml"))

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end

# Adicionando um novo metodo na classe String o ruby
class String
  def to_mongo_id
      BSON::ObjectId.from_string(self)
  end
end