import std/[
  json,
  strformat,
  options
]
import command, ../harperdb, ../config

command:
  name: getuser
  description: "Gets a user from the db if they exist"
  body:
    let uid = discordMsg.author.id.toUid()
    let res = await post(sql &"SELECT name FROM {Config.database.schema}.testUsers where uid = '{uid}'")
    if res.isSome:
      let username = parseJson(res.get())
      discard await discord.api.sendMessage(discordMsg.channelID,
          username[0]["name"].getStr())
    else:
      discard await discord.api.sendMessage(discordMsg.channelID, "Something went wrong with the server request")

