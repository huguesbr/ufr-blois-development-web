require 'httparty'
module Slack
  class Client
    DEFAULT_AUTHORIZATION = "Bearer xoxp-2486113197334-2492860403907-2492926538098-76ac2d6b0dcc5d6a24b3c72889355468"
    attr_accessor :authorization

    def self.default_client
      new(authorization: DEFAULT_AUTHORIZATION)
    end

    def initialize(authorization:)
      self.authorization = authorization
    end

    def get_conversations
      response = HTTParty.get(
        'https://slack.com/api/conversations.list?limit=50',
        headers: { Authorization: self.authorization }
      )
      response.parsed_response['channels']
    end

    def get_messages(conversation_id:)
      response = HTTParty.get(
        "https://slack.com/api/conversations.history?limit=50&channel=#{conversation_id}",
        headers: { Authorization: authorization }
      )
      response.parsed_response['messages']
    end

    def post_message(conversation_id:, text:)
      encoded_test = CGI.escape(text)
      response = HTTParty.post(
        "https://slack.com/api/chat.postMessage?limit=50&channel=#{conversation_id}&text=#{encoded_test}",
        headers: { Authorization: authorization }
      )
      response.parsed_response['message']
    end

    def update_message(conversation_id:, message_id:, text:)
      encoded_test = CGI.escape(text)
      response = HTTParty.put(
        "https://slack.com/api/chat.update?limit=50&ts=#{message_id}&channel=#{conversation_id}&text=#{encoded_test}",
        headers: { Authorization: authorization }
      )
      response.parsed_response['message']
    end

    def delete_message(conversation_id:, message_id:)
      response = HTTParty.delete(
        "https://slack.com/api/chat.delete?limit=50&ts=#{message_id}&channel=#{conversation_id}",
        headers: { Authorization: authorization }
      )
      response.parsed_response['ok']
    end
  end
end