# Projetos PBL - Melhores Compras

## Descrição do Projeto

Repositório do projeto PBL (Data Science/Engenharia de Dados) da empresa fictícia Melhores Compras, com notebooks exploratórios, scripts SQL e dados de apoio divididos por fases.

## Estrutura do Repositório

| Fase | Projeto | Foco Técnico | O que foi desenvolvido |
| :--- | :--- | :--- | :--- |
| **01** | **[SGV Genesis: Database & Logic](./Fase1-SGV-Genesis-Database-Modeling)** | Modelagem & SQL DDL | Criação dos modelos Lógico/Físico e script de categorização em Python. |
| **02** | **[SGV DataFlow: Gestão e Manipulação](./Fase2-SGV-DataFlow-Manager)** | Scripts DML/DQL & JSON | Carga de dados, relatórios SQL e integração de dados via script Python. |
| **03** | **[SGV Secure: Automação e Privacidade](./Fase3-SGV-Secure-Logic-PLSQL)** | PL/SQL & LGPD | Automação de processamento de chamados (Cursores) e adequação à LGPD. |
| **04** | **[SGV Analytics: Procedures e Estatística](./Fase4-SGV-Procedures-Statistics)** | Stored Procedures | Conversão de lógica para Procedure no Banco e análise estatística (histogramas). |
| **05** | **[SGV NoSQL Booster: Performance](./Fase5-SGV-NoSQL-Booster)** | NoSQL & Python Pandas | Estudo de performance com bancos NoSQL e análise exploratória de dados (EDA). |
| **06** | **[SGV BigData Universe: Arquitetura](./Fase6-SGV-BigData-Universe)** | Arquitetura Big Data | Desenho de solução de Data Lake, Pipelines de ingestão e gestão ágil. |
| **07** | **[SGV Insights: Power BI](./Fase7-SGV-Insights-PowerBI)** | BI & Dashboards | Dashboards interativos de vendas e governança de dados sensíveis. |

---

## O que é Feito em cada Fase

### 🔹 Fase 1: SGV Genesis
* **Modelagem:** Elaboração completa do Diagrama Entidade-Relacionamento (DER) nos níveis lógico e físico.
* **Database:** Script DDL (`Script_DDL_Melhores_Compras.sql`) para criação da estrutura inicial do banco Oracle.
* **Lógica:** Desenvolvimento de algoritmo em Python para classificar o nível de satisfação do cliente (SAC).

### 🔹 Fase 2: SGV DataFlow
* **Manipulação:** Scripts de população de dados (Insert/Update) e consultas analíticas (Selects complexos).
* **Integração:** Script Python que lê dados brutos e gera arquivos JSON estruturados para integração entre sistemas.
* **ESG:** Planejamento inicial de práticas de sustentabilidade corporativa.

### 🔹 Fase 3: SGV Secure
* **Automação:** Desenvolvimento de blocos anônimos PL/SQL utilizando cursores para varrer e processar registros do SAC.
* **Regras de Negócio:** Classificação automática de tipos de chamados (Sugestão/Reclamação) via banco de dados.
* **Privacidade:** Relatório de análise de impacto e adequação à Lei Geral de Proteção de Dados (LGPD).

### 🔹 Fase 4: SGV Analytics
  - Objetivo: Implementação de stored procedure (PL/SQL) e análise estatística de ocorrências (histograma).
  - Notebook `ex_histograma.ipynb`: exploração inicial de dados com histogramas para entender distribuições.
  - SQL `PR_SGV_CARGA_RESUMO_OCORR_SAC.sql`: rotina de carga/resumo de ocorrências SAC em base relacional.

### 🔹 Fase 5: SGV NoSQL Booster
  - Objetivo: Proposição de soluções NoSQL para problemas de desempenho e análise estatística de vendas (Python).
  - Notebook `FIAPandoDataScience_PBL_TSCOA_1o_Ano_Fase5.ipynb`: continuidade da análise da fase 4, preparação de dados e experimentação de modelos (conteúdo iterativo em notebook).

### 🔹 Fase 6: SGV BigData Universe
  - Objetivo: Definição de uma arquitetura analítica Big Data.
  - Espaço reservado para as próximas etapas (pipeline, avaliação ou deploy conforme o roteiro da disciplina).

### 🔹 Fase 7: SGV Insights
  - Objetivo: Análise de dados financeiros (Power BI/DAX) e classificação de tipos de dados.
  - `data/Clientes.xml`: amostra de dados de clientes para testes finais.
  - `reports/`: relatórios e saídas finais da fase de consolidação.

---

## Tecnologias Principais
* **Banco de Dados:** Oracle SQL, PL/SQL, NoSQL (Conceitual).
* **Linguagem:** Python (Pandas, Matplotlib, JSON).
* **Data Viz & BI:** Microsoft Power BI.
* **Ferramentas:** Oracle Data Modeler, Jupyter Notebook, Excel.

---
## Pré-requisitos

- Python 3.10+
- Ambiente virtual recomendado (venv ou similar)
- uv (opcional, para execução rápida de scripts)