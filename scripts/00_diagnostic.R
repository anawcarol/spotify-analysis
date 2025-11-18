cat("=== DIAGNÓSTICO DOS DADOS ===\n")

# Ler dados originais
spotify_original <- read.csv("data/raw/spotify_tracks.csv")
spotify_clean <- read.csv("data/processed/spotify_clean.csv")

cat("Dados originais:", nrow(spotify_original), "linhas\n")
cat("Dados limpos:", nrow(spotify_clean), "linhas\n\n")

cat("=== DISTRIBUIÇÃO DA POPULARIDADE ===\n")
cat("Original - Popularidade:\n")
print(summary(spotify_original$popularity))
cat("Zeros na popularidade original:", sum(spotify_original$popularity == 0), "\n\n")

cat("Limpo - Popularidade:\n")
print(summary(spotify_clean$popularity))
cat("Zeros na popularidade limpa:", sum(spotify_clean$popularity == 0), "\n\n")

# Verificar se há padrão nos zeros
zero_pop <- spotify_original[spotify_original$popularity == 0, ]
cat("Amostra de músicas com popularidade 0:\n")
print(head(zero_pop[, c("track_name", "artists", "track_genre")]))

# Histograma da popularidade original
png("outputs/graphs/diagnostic_original_popularity.png", width = 800, height = 600)
hist(spotify_original$popularity, breaks = 50, col = "lightblue",
     main = "Distribuição da Popularidade - Dados Originais",
     xlab = "Popularidade", ylab = "Frequência")
dev.off()

cat("\n✅ Gráfico de diagnóstico salvo: outputs/graphs/diagnostic_original_popularity.png\n")
