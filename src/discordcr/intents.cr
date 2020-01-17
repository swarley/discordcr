module Discord
  @[Flags]
  enum Intents : UInt64
    # - GUILD_CREATE
    # - GUILD_DELETE
    # - GUILD_ROLE_CREATE
    # - GUILD_ROLE_UPDATE
    # - GUILD_ROLE_DELETE
    # - CHANNEL_CREATE
    # - CHANNEL_UPDATE
    # - CHANNEL_DELETE
    # - CHANNEL_PINS_UPDATE
    Guilds

    # - GUILD_MEMBER_ADD
    # - GUILD_MEMBER_UPDATE
    # - GUILD_MEMBER_REMOVE
    GuildMembers

    # - GUILD_BAN_ADD
    # - GUILD_BAN_REMOVE
    GuildBans

    # - GUILD_EMOJIS_UPDATE
    GuildEmojis

    # - GUILD_INTEGRATIONS_UPDATE
    GuildIntegrations

    # - WEBHOOKS_UPDATE
    GuildWebhooks

    # - INVITE_CREATE
    # - INVITE_DELETE
    GuildInvites
    
    # - VOICE_STATE_UPDATE
    GuildVoiceStates
    
    # - PRESENCE_UPDATE
    GuildPresences
    
    # - MESSAGE_CREATE
    # - MESSAGE_UPDATE
    # - MESSAGE_DELETE
    GuildMessages
    
    # - MESSAGE_REACTION_ADD
    # - MESSAGE_REACTION_REMOVE
    # - MESSAGE_REACTION_REMOVE_ALL
    # - MESSAGE_REACTION_REMOVE_EMOJI
    GuildMessageReactions
    
    # - TYPING_START
    GuildMessageTyping
    
    # - CHANNEL_CREATE
    # - MESSAGE_CREATE
    # - MESSAGE_UPDATE
    # - MESSAGE_DELETE
    DirectMessages

    # - MESSAGE_REACTION_ADD
    # - MESSAGE_REACTION_REMOVE
    # - MESSAGE_REACTION_REMOVE_ALL
    # - MESSAGE_REACTION_REMOVE_EMOJI
    DirectMessageReactions
    
    # - TYPING_START
    DirectMessageTyping
  end
end