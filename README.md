# Projetos PBL - Melhores Compras

## Descrição do Projeto

Repositório do projeto PBL (Data Science/Engenharia de Dados) da empresa fictícia Melhores Compras, com notebooks exploratórios, scripts SQL e dados de apoio divididos por fases.

## Estrutura do Repositório

- `main.py`: utilitário ou ponto de entrada para execuções pontuais.
- `pyproject.toml`: metadados e dependências do projeto.
- `Fase 4/`: notebooks/SQL da fase 4 (EDA e carga SAC).
- `Fase 5/`: notebooks da fase 5 (análises e modelagem em evolução).
- `Fase 6/`: reservado para entregas da fase 6.
- `Fase 7/`: dados e relatórios da fase 7 (`data/Clientes.xml`, `reports/`).
- `.gitignore`: inclui `componentes.txt` (sensível) e artefatos temporários.

## O que é feito em cada fase

- **Fase 4**

  - Objetivo: Implementação de stored procedure (PL/SQL) e análise estatística de ocorrências (histograma).
  - Notebook `ex_histograma.ipynb`: exploração inicial de dados com histogramas para entender distribuições.
  - SQL `PR_SGV_CARGA_RESUMO_OCORR_SAC.sql`: rotina de carga/resumo de ocorrências SAC em base relacional.

- **Fase 5**
  - Objetivo: Proposição de soluções NoSQL para problemas de desempenho e análise estatística de vendas (Python).
  - Notebook `FIAPandoDataScience_PBL_TSCOA_1o_Ano_Fase5.ipynb`: continuidade da análise da fase 4, preparação de dados e experimentação de modelos (conteúdo iterativo em notebook).
- **Fase 6**
  - Objetivo: Definição de uma arquitetura analítica Big Data.
  - Espaço reservado para as próximas etapas (pipeline, avaliação ou deploy conforme o roteiro da disciplina).
- **Fase 7**
  - Objetivo: Análise de dados financeiros (Power BI/DAX) e classificação de tipos de dados.
  - `data/Clientes.xml`: amostra de dados de clientes para testes finais.
  - `reports/`: relatórios e saídas finais da fase de consolidação.

## Pré-requisitos

- Python 3.10+
- Ambiente virtual recomendado (venv ou similar)
- uv (opcional, para execução rápida de scripts)
