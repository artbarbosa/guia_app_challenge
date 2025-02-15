# Guia Challenge App

## Layout
![Demonstração](screenshots/guia.gif)

# Padrões do Projeto

## Flutter Version
A Versão do flutter que é utilizada neste projeto foi a 3.27.4.

## Apresentão geral da Arquitetura
O sistema foi dividido de forma modular, esses mesmo modulos podem conter submodules e cada modulo contém seu proprio sistema de arquitetura, cujo o utilizado neste projeto foi o Clean Dart.

![](https://user-images.githubusercontent.com/53379557/175559723-dafd93a1-2420-46c5-b1e7-ac814bcf4f2e.png)

## Segmented State Pattern

Utilizdo para permitir que um objeto altere seu comportamento quando seu estado interno mudar. O objeto aparecerá para alterar sua classe. Então é utlizado para pelos Controllers/Stores para modificar o estado das pages;

## Dependency inversion principle (DIP)

Pensando na manutenibilidade e desacoplamento, apliquei o princípio do DiP, um dos princípios do SOLID, onde as classes devem seguir uma interface (abstração) e serem uma implementação dessa interface e outras classes não devem depender da implementação e sim da interface.

## Service pattern

Utilize design pattern Service tanto para implementar as interfaces do HttpClient quanto isolar o package de database local

## Tratamento de Erros 

Como um dos aspectos mais importante durante o desenvolvimento de software, fiz o tratamento de error em suas respctivas camadas com classes criadas denominando possibilidades de erros e suas respctivas necessidades.

## Testes Unitários 

Para verificar o comportamento das unidades na aplicação e manter um desenvolvimento conciso e com maior quantidade de tratamento de erros e exceções apliquei testes unitários utilizando mocks para não criar dependência de dados externos.


# Como Utilizo o Projeto?

- Clone o projeto.
- Rode os comandos
  - `flutter pub get`
  - `flutter run`


