require "http/client"
require "openssl/ssl/context"

require "./mappings/*"
require "./version"

module Discord
  module REST
    SSL_CONTEXT = OpenSSL::SSL::Context::Client.new
    USER_AGENT  = "DiscordBot (https://github.com/meew0/discordcr, #{Discord::VERSION})"
    API_BASE    = "https://discordapp.com/api/v6"

    def request(endpoint_key : Symbol, method : String, path : String, headers : HTTP::Headers, body : String?)
      headers["Authorization"] = @token
      headers["User-Agent"] = USER_AGENT

      HTTP::Client.exec(method: method, url: API_BASE + path, headers: headers, body: body, tls: SSL_CONTEXT)
    end

    def get_gateway
      response = request(
        :get_gateway,
        "GET",
        "/gateway",
        HTTP::Headers.new,
        nil
      )

      GatewayResponse.from_json(response.body)
    end

    def get_channel(channel_id : UInt64)
      response = request(
        :get_channel,
        "GET",
        "/channels/#{channel_id}",
        HTTP::Headers.new,
        nil
      )

      Channel.from_json(response.body)
    end

    def modify_channel(channel_id : UInt64, name : String?, position : UInt32?,
                       topic : String?, bitrate : UInt32?, user_limit : UInt32?)
      json = {
        name:       name,
        position:   position,
        topic:      topic,
        bitrate:    bitrate,
        user_limit: user_limit,
      }.to_json

      response = request(
        :modify_channel,
        "PATCH",
        "/channels/#{channel_id}",
        HTTP::Headers{"Content-Type" => "application/json"},
        json
      )

      Channel.from_json(response.body)
    end

    def delete_channel(channel_id : UInt64)
      response = request(
        :delete_channel,
        "DELETE",
        "/channels/#{channel_id}",
        HTTP::Headers.new,
        nil
      )
    end

    def get_channel_messages(channel_id : UInt64, limit : UInt8 = 50, before : UInt64? = nil, after : UInt64? = nil, around : UInt64? = nil)
      path = "/channels/#{channel_id}/messages?limit=#{limit}"
      path += "&before=#{before}" if before
      path += "&after=#{after}" if after
      path += "&around=#{around}" if around

      response = request(
        :get_channel_messages,
        "GET",
        path,
        HTTP::Headers.new,
        nil
      )

      Array(Message).from_json(response.body)
    end

    def get_channel_message(channel_id : UInt64, message_id : UInt64)
      response = request(
        :get_channel_message,
        "GET",
        "/channels/#{channel_id}/messages/#{message_id}",
        HTTP::Headers.new,
        nil
      )

      Message.from_json(response.body)
    end

    def create_message(channel_id : UInt64, content : String)
      response = request(
        :create_message,
        "POST",
        "/channels/#{channel_id}/messages",
        HTTP::Headers{"Content-Type" => "application/json"},
        {content: content}.to_json
      )

      Message.from_json(response.body)
    end

    # TODO: Add the upload file endpoint when the multipart PR is merged

    def edit_message(channel_id : UInt64, message_id : UInt64)
      response = request(
        :edit_message,
        "PATCH",
        "/channels/#{channel_id}/messages/#{message_id}",
        HTTP::Headers{"Content-Type" => "application/json"},
        {content: content}.to_json
      )

      Message.from_json(response.body)
    end

    def delete_message(channel_id : UInt64, message_id : UInt64)
      response = request(
        :delete_message,
        "DELETE",
        "/channels/#{channel_id}/messages/#{message_id}",
        HTTP::Headers.new,
        nil
      )
    end

    def bulk_delete_messages(channel_id : UInt64, message_ids : Array(UInt64))
      response = request(
        :bulk_delete_messages,
        "POST",
        "/channels/#{channel_id}/messages/bulk_delete",
        HTTP::Headers{"Content-Type" => "application/json"},
        message_ids.to_json
      )
    end

    def edit_channel_permissions(channel_id : UInt64, overwrite_id : UInt64,
                                 type : String, allow : UInt64, deny : UInt64)
      json = {
        allow: allow,
        deny:  deny,
        type:  type,
      }.to_json

      response = request(
        :edit_channel_permissions,
        "PUT",
        "/channels/#{channel_id}/permissions/#{overwrite_id}",
        HTTP::Headers{"Content-Type" => "application/json"},
        json
      )
    end

    def get_channel_invites(channel_id : UInt64)
      response = request(
        :get_channel_invites,
        "GET",
        "/channels/#{channel_id}/invites",
        HTTP::Headers.new,
        nil
      )

      Array(InviteMetadata).from_json(response.body)
    end
  end
end
