names <- df_main %>% select(c('MATCH.ID'), contains("MEMBERS"))

names <- names %>% mutate(
  TEAM.MEMBERS.as.list = strsplit(TEAM.MEMBERS, "\n"),
  ENEMY.TEAM.MEMBERS.as.list = strsplit(ENEMY.TEAM.MEMBERS, "\n")
)

names <- names %>% mutate(
  "no.of.team.members" = sapply(names$TEAM.MEMBERS.as.list, length),
  "no.of.enemy.members" = sapply(names$ENEMY.TEAM.MEMBERS.as.list, length)
)

names <- names %>% filter(no.of.team.members == 4 & no.of.enemy.members == 4)

for (i in c(1,2,3,4)) {
  names[[paste0('TEAM.MEMBER.',i)]] <- sapply(names$TEAM.MEMBERS.as.list, function(x){x[[i]]})
  names[[paste0('ENEMY.TEAM.MEMBER.',i)]] <- sapply(names$ENEMY.TEAM.MEMBERS.as.list, function(x){x[[i]]})
}

player_names <- tibble(
  player = c(names$TEAM.MEMBERS.as.list, names$ENEMY.TEAM.MEMBERS.as.list) %>% unlist()
) %>%
  count(player, sort=T)
