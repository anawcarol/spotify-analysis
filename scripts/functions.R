# Funções utilitárias para análise do Spotify
# Autor: [Seu Nome]

# Função para calcular estatísticas por artista
artist_stats <- function(data, artist) {
  data %>%
    filter(main_artist == artist) %>%
    summarise(
      avg_popularity = mean(popularity, na.rm = TRUE),
      avg_danceability = mean(danceability, na.rm = TRUE),
      avg_energy = mean(energy, na.rm = TRUE),
      total_songs = n(),
      most_popular_song = track_name[which.max(popularity)]
    )
}

# Função para análise de tendências
yearly_trends <- function(data, variable) {
  data %>%
    group_by(year) %>%
    summarise(avg_value = mean({{variable}}, na.rm = TRUE)) %>%
    ggplot(aes(x = year, y = avg_value)) +
    geom_line(color = "#1DB954") +
    geom_point(color = "#1DB954") +
    labs(title = paste("Evolução de", deparse(substitute(variable))),
         y = deparse(substitute(variable)))
}