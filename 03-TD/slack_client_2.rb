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
      conversations = response.parsed_response['channels']
      # convert the array of conversation hashes in an array of conversation objects
      conversations.map do |conversation|
        Conversation.new(id: conversation['id'], name: conversation['name'])
      end
    end

    def get_messages(conversation_id:)
      response = HTTParty.get(
        "https://slack.com/api/conversations.history?limit=50&channel=#{conversation_id}",
        headers: { Authorization: authorization }
      )
      # convert the array of messages hashes in an array of message objects
      messages = response.parsed_response['messages']
      messages.map do |message|
        Message.new(id: message['ts'], text: message['text'], conversation_id: conversation_id)
      end
    end

    def post_message(conversation_id:, text:)
      encoded_test = CGI.escape(text)
      response = HTTParty.post(
        "https://slack.com/api/chat.postMessage?limit=50&channel=#{conversation_id}&text=#{encoded_test}",
        headers: { Authorization: authorization }
      )
      message = response.parsed_response['message']
      Message.new(id: message['ts'], text: message['text'], conversation_id: conversation_id)
    end

    def update_message(conversation_id:, message_id:, text:)
      encoded_test = CGI.escape(text)
      response = HTTParty.put(
        "https://slack.com/api/chat.update?limit=50&ts=#{message_id}&channel=#{conversation_id}&text=#{encoded_test}",
        headers: { Authorization: authorization }
      )
      response.parsed_response['message']
      message = response.parsed_response['message']
      Message.new(id: message['ts'], text: message['text'], conversation_id: conversation_id)
    end

    def delete_message(conversation_id:, message_id:)
      response = HTTParty.delete(
        "https://slack.com/api/chat.delete?limit=50&ts=#{message_id}&channel=#{conversation_id}",
        headers: { Authorization: authorization }
      )
      response.parsed_response['ok']
    end
  end

  class Conversation
    attr_accessor :id, :name

    def initialize(id:, name:)
      self.id = id
      self.name = name
    end

    def get_messages
      client.get_messages(
        conversation_id: self.id
      )
    end

    def create_message(text:)
      client.post_message(
        conversation_id: self.id,
        text: text
      )
    end

    private

    def client
      Client.default_client
    end
  end

  class Message
    attr_accessor :id, :text, :conversation_id

    def initialize(id:, text:, conversation_id:)
      self.id = id
      self.text = text
      self.conversation_id = conversation_id
    end

    def update(text:)
      client.update_message(
        conversation_id: conversation_id,
        message_id: self.id,
        text: text
      )
    end

    def delete
      client.delete_message(
        conversation_id: conversation_id,
        message_id: self.id
      )
    end

    private

    def client
      Client.default_client
    end
  end
end