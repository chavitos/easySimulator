# easySimulator

Simulador de renda fixa com base na [API](https://github.com/easynvest/api-simulator-calc).

Para esse projeto foi utilizada a arquitetura [Clean Swift](https://clean-swift.com/) que é uma arquitetura baseada no conceito de ciclo VIP (view -> interactor -> presenter -> view). Essa arquitetura foi escolhida por utilizar um conceito sólido VIP com grande desacoplamento, onde cada classe tem a sua função exata de acordo com o protocolo que implementa, facilitando o entendimento do código, a manutenção e a escrita dos testes unitários.

Nesse projeto uma arquitetura MVC (arquitetura default iOS) já serviria perfeitamente, levando em conta a baixa complexidade do fluxo e das regras de negócio do mesmo, porém, achei legal a oportunidade de testar essa arquitetura que havia ouvido falar um tempo atrás então decidi estudar e aplicar a mesma.
