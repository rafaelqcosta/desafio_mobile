## Desafio Mobile

# Para rodar a aplicação localmente
instale as dependências
- flutter pub get

execute
- flutter run

# Para instalar o app direto no Android
- baixe e instale: (https://github.com/rafaelqcosta/desafio_mobile/blob/main/app-release.apk)


# Descrição do projeto

1. Tela de login usando (email e senha);
2. Tela home com mapa renderizando um ponto na localização atual do device;
3. Realizar o login utilizando Firebase Auth;
4. Armazenar os dados do usuário na store global;
5. Rastrear login com sucesso e renderização com sucesso com Analytics (enviar um evento com dados considerados primordiais nesses dois casos);
6. Rastrear os erros e envia-los ao Crashlytics;
7. Armazenar na base de dados local (preferência por WatermelonDB, mas pode usar outro banco de dados) o usuário logado e sua última posição no mapa;
8. Testar fluxo de login (unit e e2e);
9. Testar fluxo da home (unit e e2e).

obs.: além das views solicitadas, foi criado mais duas com o intuito de apresentar os dados do item 4 e 7.



