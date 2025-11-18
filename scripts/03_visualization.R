# Visualização Básica - Versão R Base
# Autor: [Seu Nome]

cat("=== CRIANDO VISUALIZAÇÕES BÁSICAS ===\n")

# Carregar dados
spotify <- read.csv("data/processed/spotify_clean.csv")
popularity_by_year <- read.csv("outputs/tables/popularity_by_year.csv")
top_artists <- read.csv("outputs/tables/top_artists.csv")

# 1. Gráfico de linha: Evolução da popularidade
png("outputs/graphs/01_popularity_trends.png", width = 800, height = 600)
plot(popularity_by_year$year, popularity_by_year$avg_popularity, 
     type = "o", col = "#1DB954", lwd = 2, pch = 16,
     main = "Evolução da Popularidade Média (2000-2024)",
     xlab = "Ano", ylab = "Popularidade Média")
grid()
dev.off()

# 2. Gráfico de barras: Top artistas
png("outputs/graphs/02_top_artists.png", width = 800, height = 600)
par(mar = c(5, 12, 4, 2))  # Ajustar margens
top10 <- head(top_artists[order(top_artists$avg_popularity), ], 10)
barplot(top10$avg_popularity, names.arg = top10$main_artist, 
        horiz = TRUE, las = 1, col = "#1DB954", border = NA,
        main = "Top 10 Artistas Mais Populares",
        xlab = "Popularidade Média")
dev.off()

# 3. Histograma: Distribuição da popularidade
png("outputs/graphs/03_popularity_distribution.png", width = 800, height = 600)
hist(spotify$popularity, breaks = 30, col = "#1DB954", border = "white",
     main = "Distribuição da Popularidade das Músicas",
     xlab = "Popularidade", ylab = "Frequência")
dev.off()

# 4. Scatter plot: Duração vs Popularidade
png("outputs/graphs/04_duration_vs_popularity.png", width = 800, height = 600)
sample_data <- spotify[sample(nrow(spotify), 1000), ]  # Amostra para visualização
plot(sample_data$duration_min, sample_data$popularity,
     pch = 16, col = rgb(29/255, 185/255, 84/255, 0.5),
     main = "Relação entre Duração e Popularidade",
     xlab = "Duração (minutos)", ylab = "Popularidade")
abline(lm(popularity ~ duration_min, data = sample_data), col = "red", lwd = 2)
dev.off()

cat("✅ 4 gráficos salvos em outputs/graphs/\n")
