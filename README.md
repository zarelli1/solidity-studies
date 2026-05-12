# 🛡️ Ecosystem One: Laboratório de Smart Contracts & Segurança

Bem-vindo ao laboratório aberto de Leonardo Zarelli.

Este repositório é o meu *Proof of Work* (Prova de Trabalho) contínuo na jornada como Web3 Security Researcher. Aqui documento meus estudos, testes e experimentos focados na Ethereum Virtual Machine (EVM) e na segurança de protocolos DeFi.

> *"No ecossistema Web3, o código é a lei. Meu trabalho é entender essa lei linha por linha para garantir que ela seja à prova de balas."*

---

### 🔐 Módulo Base: Web3 OpSec & Gestão de Risco (Concluído)
- [x] Vetores de Ameaça e Categorização de Wallets (Hot vs. Cold)
- [x] Arquitetura Multi-Sig e Smart Contract Wallets (Safe)
- [x] Social Recovery e Fragmentação de Chaves (Shamir's Secret Sharing - SSS)
- [x] Disaster Recovery, Padrão BIP-39 e Hierarquia de Chaves
- [x] Auditoria Prática de Transações e Anti-Blind Signing (MetaMask & Etherscan)
- [x] Verificação de Assinaturas (Payloads) e Derivation Paths em Hardware Wallets

## 🗺️ Roadmap de Auditoria e Desenvolvimento (Trilha Cyfrin)

### 📦 Módulo 1: Fundamentos da EVM (Simple Storage)
- [x] Variáveis de Estado e Funções de Leitura/Escrita
- [x] Tipos Complexos: Structs, Arrays e Gestão de Memória (`memory` vs `storage`)
- [ ] Otimização e Busca Eficiente: Mapeamentos (Mappings)
- [ ] Tratamento de Erros de Compilação e Avisos
- [ ] Deploy de Contratos Inteligentes em Testnets

### 🏭 Módulo 2: Componibilidade (Storage Factory)
- [ ] Padrão de Fábrica: Deploy de contratos a partir de outros contratos
- [ ] Organização de Código: Importações locais e nomeadas
- [ ] Comunicação Cross-Contract: Interação usando ABIs
- [ ] Arquitetura de Software: Herança (Inheritance) e Override no Solidity

### 💸 Módulo 3: Finanças Descentralizadas (Fund Me)
- [ ] Transações Nativas: Enviando e recebendo ETH (`payable`, `msg.value`)
- [ ] Manipulação de Gás e Reverts (O Custo da Escassez)
- [ ] Oráculos Descentralizados: Consumindo dados de preços com a Chainlink
- [ ] Integração Externa: Interfaces e importação via NPM/GitHub
- [ ] Matemática na EVM: Tratamento de decimais, `SafeMath` e conversões
- [ ] Controle de Acesso: O papel do `msg.sender` e variáveis globais
- [ ] Otimização de Código: Criação de Bibliotecas Customizadas (Libraries)
- [ ] Padrões de Interação: Loops e redefinição de Arrays
- [ ] Riscos de Transferência: Diferenças críticas entre `transfer`, `send` e `call`
- [ ] Proteção Administrativa: Construtores e Modificadores (`modifiers`)
- [ ] Gas Optimization Mestre: Variáveis `immutable`, `constant` e Custom Errors
- [ ] Tratamento de Transações Órfãs: Funções `receive` e `fallback`

---
🔗 **Conecte-se à Trincheira:** [Substack](https://leonardozarelli.substack.com) | [YouTube](https://www.youtube.com/@Leonardo_Zarelli) | [LinkedIn](https://www.linkedin.com/in/leonardo-zarelli/) | [X / Radar](https://x.com/lzrgeracaoz2000)
