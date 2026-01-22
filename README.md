# Vakinha Burger - Delivery App

Este é um aplicativo de delivery desenvolvido utilizando o framework Flutter. O projeto utiliza diversas bibliotecas populares para gerenciamento de estado, requisições HTTP e UI.

## 📋 Funcionalidades e Tecnologias

O projeto foi construído com as seguintes tecnologias e pacotes:

- **Gerenciamento de Estado**: [flutter_bloc](https://pub.dev/packages/flutter_bloc)
- **Requisições HTTP**: [dio](https://pub.dev/packages/dio)
- **Armazenamento Local**: [shared_preferences](https://pub.dev/packages/shared_preferences)
- **Validação de Formulários**: [validatorless](https://pub.dev/packages/validatorless)
- **Interface de Usuário**:
  - [top_snackbar_flutter](https://pub.dev/packages/top_snackbar_flutter) para notificações.
  - [loading_animation_widget](https://pub.dev/packages/loading_animation_widget) para carregamentos.
  - [auto_size_text](https://pub.dev/packages/auto_size_text) para textos responsivos.
  - Fonte personalizada: **M Plus 1**.
- **Injeção de Dependência**: [provider](https://pub.dev/packages/provider)
- **Match**: [match](https://pub.dev/packages/match) para pattern watching e variantes.

## 🛠️ Pré-requisitos

Para executar este projeto, você precisará do **Flutter** instalado e configurado em sua máquina.

### Versão do SDK

Este projeto requer o SDK do Dart na versão **^3.9.2**. Certifique-se de ter uma versão do Flutter compatível com este SDK.

Verifique sua versão atual com:

```bash
flutter --version
```

## 🚀 Como Executar

Siga os passos abaixo para rodar o projeto em seu ambiente local:

1. **Clone o repositório** (caso ainda não tenha feito):

   ```bash
   git clone <url-do-seu-repositorio>
   cd deliveri_app
   ```

2. **Instale as dependências**:
   Execute o comando abaixo na raiz do projeto para baixar baixar todos os pacotes necessários listados no `pubspec.yaml`:

   ```bash
   flutter pub get
   ```

3. **Geração de arquivos (Build Runner)**:
   Como o projeto utiliza pacotes que requerem geração de código (como `match` com `match_generator`), execute o build runner:

   ```bash
   dart run build_runner build
   ```

4. **Configuração de Variáveis de Ambiente**:
   Verifique se o arquivo `.env` está configurado corretamente na raiz do projeto ou na pasta mapeada em `assets`, conforme definido no `pubspec.yaml`.

5. **Execute o App**:
   Conecte um dispositivo ou inicie um emulador e rode o comando:
   ```bash
   flutter run
   ```

## 📁 Estrutura de Pastas

A estrutura principal do código fonte está localizada em `lib/`:

- `lib/app/`: Contém o código principal da aplicação (pages, widgets, models, controllers).
- `assets/`: Imagens, fontes e arquivos de configuração.

---

Desenvolvido como parte do projeto Vakinha Burger.

## Prints do projeto

<div align="center">
  <img src="https://github.com/user-attachments/assets/3f4e60d9-1451-4f59-8bda-a4b116d8b055" alt="Imagem 1" width="300px">
  <img src="https://github.com/user-attachments/assets/e200fd41-beed-4f93-b717-f88787178702" alt="Imagem 2" width="300px">
  <img src="https://github.com/user-attachments/assets/df9d5877-350e-4763-8d38-db29277c421f" alt="Imagem 3" width="300px">
  <img src="https://github.com/user-attachments/assets/ad6728df-f7ea-47a1-966b-fa1ebef7f6bb" alt="Imagem 4" width="300px">
</div>
