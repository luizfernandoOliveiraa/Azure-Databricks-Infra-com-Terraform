# Azure Data Engineering Lab - IaC com Terraform 🚀☁️

Este repositório contém o código-fonte como Infraestrutura (IaC - *Infrastructure as Code*) para o provisionamento automatizado de um ambiente moderno e escalável de **Engenharia de Dados** na Microsoft Azure, adotando os mais altos padrões de **DataOps** e **FinOps**.

---

## 💡 Motivação e Ideia do Projeto

Times de Engenharia de Dados costumam sofrer com a criação manual de recursos no Portal da Nuvem. Além de gastar horas configurando permissões, redes e integrações (como conectar o Databricks ao Data Lake ou criar instâncias do Data Factory), qualquer erro humano na configuração de um ambiente de *Produção* em comparação ao de *Desenvolvimento* pode gerar bugs catastróficos que só são descobertos quando os pipelines de dados já estão em falha.

Este projeto visa resolver exatamente esse gargalo. Ele entrega um laboratório **pronto, documentado e versionado** usando o **Terraform**, com o objetivo de levantar todos os recursos essenciais para criar uma plataforma de dados moderna em questão de minutos, garantindo que o ciclo de vida dos dados seja tratado com o mesmo rigor cirúrgico que o desenvolvimento de software profissional.

### 🏗️ Arquitetura Provisionada
Toda a infraestrutura é criada baseada na plataforma Azure e empacotada em uma arquitetura de módulos, onde o mesmo código levanta ambientes de **DEV** e **PROD** com distinções de custos e resiliência financeira. Os recursos subidos são:

* 📦 **Resource Group:** O contêiner de gerência para empacotar o ciclo de vida dos recursos.
* 📂 **Azure Data Lake Storage Gen2 (ADLS2):** Armazenamento otimizado para Big Data (habilitado via *Hierarchical Namespace*), rodando com redundância LRS (Desenvolvimento) e GRS (Produção).
* 🏭 **Azure Data Factory (ADF):** Ferramenta principal de ingestão e orquestração de fluxos ETL/ELT.
* ⚡ **Azure Databricks Workspace:** Cluster computacional Apache Spark otimizado. **Com otimização FinOps:** diferenciando SKU's `Standard` para Dev e `Premium` para Prod (viabilizando controle de acesso RBAC).

---

## 💎 Por que usar o Terraform melhora a qualidade e o tempo de entrega das equipes de Engenharia de Dados?

O uso do Terraform transforma a infraestrutura de Data Platform em código versionável. Isso resulta em benefícios avassaladores:

1. **Paridade entre Ambientes (Fim do "na minha máquina funciona"):** Como o ambiente de Produção e o de Desenvolvimento utilizam o mesmo _Módulo_, a infraestrutura é idêntica por design. Se o Databricks integrar corretamente com o ADLS no DEV, ele fará em PROD.
2. **Tempo de Entrega (Time-to-Market):** Levantar toda complexidade do ecossistema Databricks e ADF manualmente no Portal do Azure leva de 30 a 60 minutos se você for rato no portal. Com o Terraform, toda rede, cluster e storage sobem paralelos em menos de `5 minutos`.
3. **Rollback de Desastres e DR (Disaster Recovery):** Em caso de comprometimento completo da subscrição Cloud por erro ou ataque, uma esteira de CI/CD (já configurada neste repositório usando o GitHub Actions) e alguns comandos recriam 100% da arquitetura física do zero.
4. **Governança de Custos e FinOps Integrados:** Utilizando *Tags* aplicadas uniformemente em todos os recursos através do `variables.tf`, gestores conseguem auditar na conta da Azure exatamente quanto dinheiro o ambiente *"DataEng-Dev"* está consumindo em tempo real.
5. **Automação Segura e GitOps:** Usando fluxos isolados por Branch (`development` e `main`) e Remote State no *blob storage*, mudanças estruturais passam a ser revisáveis no Pull Request de código (`terraform plan`). Nada vai pro ar sem aprovação do Tech Lead. Cibersegurança garantida sem senhas chumbadas em scripts.

---

## 🌟 Destaques do Pipeline de CI/CD Avançado

Este projeto abraça práticas do estado da arte de **GitOps** com aprovações de segurança integradas.

- 🛡️ **Aprovação Manual (Production Environment):** O job de Produção foi configurado de forma nativa (`environment: production`) para exigir **aprovação humana (Review)** no GitHub. Em vez de quebrar a automação tirando a flag `-auto-approve`, o Github pausa a pipeline *antes* da execução. Apenas após a revisão de um Lead, o robô liga e aplica as mudanças, provendo imensa segurança e rastreabilidade visual (Sem terminais travados pedindo para digitar YES).
- 🧹 **Workflow de Destruição Limpa (Destroy):** Para evitar cobranças "fantasmas" indesejadas na nuvem por laboratórios esquecidos ligados, um job foi criado em `.github/workflows/destroy.yml`. Ele pode ser disparado manualmente a qualquer momento pela aba **Actions** no Github usando *workflow_dispatch*, permitindo dizimar todos os recursos com apenas 1 clique em um botão, remotamente!

---

## 📂 Como o Repositório Está Organizado?

Empregamos a melhor prática de "Terraform Modules".
```text
📦 lab-dataengineer
 ┣ 📂 .github
 ┃ ┗ 📂 workflows
 ┃   ┣ 📜 terraform.yml  (A esteira automatizada CI/CD)
 ┃   ┗ 📜 destroy.yml    (Rotina de expurgo sob-demanda)
 ┣ 📂 modules
 ┃ ┗ 📂 data_platform 
 ┣ 📂 dev                
 ┣ 📂 prod               
```

## 🚀 Como fazer o deploy?

### Pré-requisitos:
- Instalação do [Terraform CLI](https://developer.hashicorp.com/terraform/downloads) e do [Azure CLI (`az`)](https://learn.microsoft.com/pt-br/cli/azure/install-azure-cli) caso vá rodar local;
- Uma conta logada (`az login`);
- O Estado do projeto fica remoto no Azure, portanto já exista um container previamente nomeado `tfstate`.

### Rodando o projeto de Desenvolvimento (Localmente):
```bash
cd dev
terraform init
terraform plan
terraform apply
```

*(Ou simplesmente realize o `git push` para sua respectiva branch (como `development`) que a esteira de CI/CD subirá/modificará tudo automaticamente no provedor em nuvem Azure)*.
