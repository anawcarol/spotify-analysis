# Análise Exploratória - Versão R Base
# Autor: [Seu Nome]

cat("=== ANÁLISE EXPLORATÓRIA ===\n")

# Carregar dados
spotify <- read.csv("data/processed/spotify_clean.csv")

# Estatísticas básicas
cat("Estatísticas descritivas:\n")
cat("Popularidade - Média:", round(mean(spotify$popularity), 2), "\n")
cat("Popularidade - Mediana:", median(spotify$popularity), "\n")
cat("Duração média:", round(mean(spotify$duration_min), 2), "minutos\n")
cat("Total de artistas únicos:", length(unique(spotify$main_artist)), "\n")

# Análise por ano (após 2000)
recent_data <- spotify[spotify$year >= 2000, ]
popularity_by_year <- aggregate(popularity ~ year, data = recent_data, mean)
names(popularity_by_year)[2] <- "avg_popularity"

# Contar músicas por ano
songs_by_year <- aggregate(track_id ~ year, data = recent_data, length)
names(songs_by_year)[2] <- "n_songs"

# Juntar as análises
yearly_analysis <- merge(popularity_by_year, songs_by_year, by = "year")

# Top artistas (com pelo menos 5 músicas)
artist_counts <- aggregate(track_id ~ main_artist, data = spotify, length)
names(artist_counts)[2] <- "total_songs"

artist_popularity <- aggregate(popularity ~ main_artist, data = spotify, mean)
names(artist_popularity)[2] <- "avg_popularity"

top_artists <- merge(artist_popularity, artist_counts, by = "main_artist")
top_artists <- top_artists[top_artists$total_songs >= 5, ]
top_artists <- head(top_artists[order(-top_artists$avg_popularity), ], 20)

# Salvar resultados
write.csv(yearly_analysis, "outputs/tables/popularity_by_year.csv", row.names = FALSE)
write.csv(top_artists, "outputs/tables/top_artists.csv", row.names = FALSE)

cat("✅ Análise salva em outputs/tables/\n")
cat("Top artista:", top_artists$main_artist[1], "- Popularidade:", round(top_artists$avg_popularity[1], 2), "\n")
cat("Ano com mais músicas:", yearly_analysis$year[which.max(yearly_analysis$n_songs)], "\n")
