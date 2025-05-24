# Academy Project

## Documentos

- [Diagrama Conceitual](documents/conceptual_diagram_adw.pdf)
- [Arquivo do Dashboard](documents/adw_bi_v2.pbix)
- [Vídeo de Apresentação](https://youtu.be/lRF0pSNLX-Q)
- [Vídeo para novo painel](https://youtu.be/L6ANsK7hQHY)

## Resumo do Projeto

Este projeto para a Adventure Works tem como objetivo transformar a análise de dados da empresa por meio de duas etapas principais:

1. **Modelagem Dimensional**: Criação de um Data Warehouse utilizando o snowflake e dbt, organizando dados de vendas e produção.
2. **Visualização de Dados**: Desenvolvimento de dashboards interativos para análise visual dos dados.

## Divisão do Projeto

### Transformação dos Dados
- **Modelagem Dimensional**: 
    - Criação de tabelas de fatos e dimensões para responder às perguntas de negócios.
    - Implementação de boas práticas de modelagem dimensional com o **dbt**.

### Visualização dos Dados:
- **Desenvolvimento de Dashboards Interativos**:
    - Criação de dashboards de nível operacional e executivo utilizando **Power BI**.
    - Aplicação de boas práticas de visualização para facilitar a análise e interpretação dos dados.

## Ferramentas Utilizadas

### Coleta e Armazenamento de Dados
- **Fonte dos dados**: Infraestrutura SAP, CRM Salesforce, web analytics e outros.
- **Plataforma de armazenamento**: Snowflake

### Transformação de Dados
- **Ferramenta utilizada**: dbt Core
    - O dbt foi utilizado para construir a modelagem dimensional e garantir a integridade dos dados.
    - **Tabelas de Dimensões**:
      - `dim_dates`, `dim_customer`, `dim_locales`, `dim_personcreditcard`, `dim_products`, `dim_salesreason`.
    - **Tabelas de Fato e Agregadas**:
      - `fct_ordersales`, `agg_sales_locales`, `agg_sales_seller`.
    - Utilizou-se materialização do tipo `tabela` para armazenar dados de forma persistente no data warehouse, garantindo consultas rápidas e consistentes.
    - Arquivos YAML foram criados para documentar as dimensões e incluir testes de integridade e precisão dos dados.

### Visualização e Dashboard
- **Ferramenta utilizada**: Power BI
    - Foram desenvolvidos dois dashboards, um de nível operacional e outro de nível executivo, para apoiar a tomada de decisões estratégicas.

## Instruções

### Configuração de Ambiente

1. **Clone o repositório**:
    ```bash
    git clone https://github.com/manueladinizc/dbt-academy.git
    cd dbt-academy
    ```

2. **Crie um ambiente virtual**:
    ```bash
    python -m venv venv
    source venv/bin/activates
    ```

3. **Instale as dependências**:
    ```bash
    pip install -r requirements.txt
    ```

4. **Configure as credenciais do projeto** no arquivo `profiles.yml`.

6. **Execute e teste**:
    ```bash
    dbt run
    dbt test
    ```