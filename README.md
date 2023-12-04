# ebook_reader

Esse aplicativo foi elaborado para servir como uma estante de ebooks e permitir que os usuários gerenciem esses ebooks de acordo com sua preferências.

## Observação

- O projeto foi desenvolvido utilizando a versão 3.16.0 do Flutter e 3.2.0 do Dart.

## Instruções para executar o projeto

### Certifique-se de ter as seguintes ferramentas instaladas em sua máquina:

- Flutter SDK
- Dart SDK
- IDE Flutter (recomendado: VS Code)

1. **Clone o Repositório:**

   ```
   git clone https://github.com/ericarodrigs/ebook-reader.git
   ```

2. **Navegue até o Diretório do Projeto:**
    ```
    cd ebook-reader
    ```
3. **Instale as Dependências**
    ```
    flutter pub get
    ```
4. **Execute o Projeto**

    ```
    flutter run
    ```

## Principais bibliotecas utilizadas

permission_handler - gerenciador de permissões
get_it - injetor de dependências
go_router - navegação do app
http - serviço de acesso ao client
flutter_bloc - gerenciamento de estados da aplicação 
freezed_annotation - gerador de códigos
vocsy_epub_viewer - leitor de epub
sqflite - armazenamento local
