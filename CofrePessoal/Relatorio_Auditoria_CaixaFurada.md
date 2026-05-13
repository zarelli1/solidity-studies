# Estudo de Caso: O Colapso do Banco Caixa Furada

## O Problema
O Banco Caixa Furada faliu por dois erros de arquitetura:
1. **Comunismo de Dados:** O saldo de todos ficava em uma variável só.
2. **Reentrância:** O banco pagava antes de anotar no sistema.

##  O Desafio
Como implementar um sistema que individualize os saldos e impeça ataques de reentrância?

## A Soluçãodo Código)

### 1. Individualização com `mapping`
Na linha `mapping(address => uint256) public saldos;`, resolvemos o erro do comunismo. Cada carteira agora tem sua própria "gaveta" de dinheiro.

### 2. A "resolução" da Reentrância (Padrão CEI)
Na função `sacar`, usamos a ordem: **Check -> Effect -> Interaction**.
- **Check:** `require` verifica se há saldo.
- **Effect:** `saldos[msg.sender] -= _valor;` (Reduzimos o saldo no sistema **ANTES** de entregar o dinheiro).
- **Interaction:** `call` envia o dinheiro.

*Dessa forma, se um hacker tentar sacar duas vezes, no segundo pedido o sistema já lerá que o saldo dele é zero.*
