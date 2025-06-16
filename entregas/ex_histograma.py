import pandas as pd
import matplotlib.pyplot as plt

# Carregue o arquivo CSV (ajuste o caminho se necessário)
df = pd.read_csv(r"\ASSETS_FIAP_ON_TSCO_PBL_1o_Ano_Fase_4_v4\Desafio2\ocorrencias_sac.csv")

# Corrigir nomes de colunas (remover espaços extras)
df.columns = df.columns.str.strip()

# Converter a coluna de data para o tipo datetime
df["data_ocorrencia"] = pd.to_datetime(df["data_ocorrencia"])

# Contar o número de ocorrências por data
frequencias = df["data_ocorrencia"].value_counts().sort_index()

# Calcular a distribuição de probabilidade (frequência relativa)
distribuicao_prob = frequencias / frequencias.sum()

# Criar os gráficos
fig, axs = plt.subplots(2, 1, figsize=(12, 8), constrained_layout=True)

# Histograma de frequências absolutas
axs[0].bar(frequencias.index, frequencias.values, color='skyblue')
axs[0].set_title("Frequência de Ocorrências por Dia")
axs[0].set_xlabel("Data")
axs[0].set_ylabel("Número de Ocorrências")
axs[0].tick_params(axis='x', rotation=45)

# Histograma de distribuição de probabilidade
axs[1].bar(distribuicao_prob.index, distribuicao_prob.values, color='orange')
axs[1].set_title("Distribuição de Probabilidade das Ocorrências por Dia")
axs[1].set_xlabel("Data")
axs[1].set_ylabel("Probabilidade")
axs[1].tick_params(axis='x', rotation=45)

plt.show()
