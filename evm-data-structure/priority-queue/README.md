# Smart Contract: Fila de Prioridade (Priority Queue)

## Visão Geral

Este repositório contém a implementação de um contrato inteligente em Solidity que gerencia uma **Fila de Prioridade baseada em Min-Heap**.

Diferente de uma fila tradicional (FIFO), onde o primeiro a chegar é o primeiro a ser atendido, este contrato funciona como a triagem de um Pronto-Socorro: **a urgência dita a ordem de execução, independentemente do tempo de espera.** Quanto menor o número de prioridade, mais urgente o item.

---

## Arquitetura

O contrato armazena os dados em um array dinâmico (`No[] private pilha`) tratado internamente como uma **árvore binária completa (Min-Heap)**. Cada elemento é uma struct com dois campos:

- `prioridade` — número inteiro; quanto menor, mais urgente.
- `dado` — o conteúdo do item (ID do usuário, ID da transação, nome da tarefa, etc).

A posição de cada elemento no array define sua relação com os demais via fórmula matemática, sem ponteiros:

```
pai(i)       = (i - 1) / 2
filho esq(i) = 2 * i + 1
filho dir(i) = 2 * i + 2
```

A propriedade fundamental mantida em todo momento: `pilha[pai].prioridade <= pilha[filho].prioridade`. Isso garante que o elemento de menor prioridade esteja **sempre no índice 0**.

---

## Funções

### `enqueue(uint256 prioridade, string dado)` — inserção

1. O novo elemento é inserido no fim do array (`pilha[tamanho]`).
2. O algoritmo **heapify-up** compara o elemento com seu pai e os troca enquanto o filho for menor.
3. O loop para quando o heap estiver correto ou quando chegar na raiz.

Custo: **O(log n)** — sobe no máximo a altura da árvore.

### `dequeue()` — remoção do mais urgente

1. Salva a raiz (`pilha[0]`), que é sempre o menor elemento.
2. Move o último elemento para a raiz e decrementa `tamanho` manualmente — sem usar `.pop()` nativo.
3. O algoritmo **heapify-down** compara o elemento com seus dois filhos e troca com o menor deles, repetindo até o heap estar correto.

Custo: **O(log n)** — desce no máximo a altura da árvore.

### `peek()` — consulta sem remoção

Retorna o elemento de menor prioridade sem modificar a fila. Acesso direto a `pilha[0]`.

Custo: **O(1)**.

### `size()` — tamanho atual

Retorna quantos elementos estão na fila.

Custo: **O(1)**.

---

## Padrão de controle de tamanho

O contrato utiliza uma variável `uint256 private tamanho` para controlar o número de elementos válidos no array, em vez de depender de `.length` ou `.pop()` nativo. Isso permite reutilizar slots liberados por `dequeue` em inserções futuras, reduzindo escritas desnecessárias no storage.

---

## Otimização de Gas

| operação | busca linear (O(n)) | min-heap (este contrato) |
|---|---|---|
| inserir | O(1) | O(log n) |
| remover o mais urgente | O(n) + O(1) swap | O(log n) |
| consultar o mais urgente | O(n) | O(1) |

A busca linear percorre o array inteiro a cada remoção. Em filas grandes na Blockchain, isso esgota o limite de Gas da transação. O Min-Heap elimina esse gargalo: o elemento mais urgente está sempre na raiz, e tanto a inserção quanto a remoção percorrem no máximo a altura da árvore — que cresce de forma logarítmica com o número de elementos.

---

## Casos de Uso no Mundo Real (Web3)

- **DeFi** — fila de liquidação de garantias, priorizando empréstimos com maior risco de insolvência.
- **DAOs** — fila de execução de propostas, onde correções de segurança furam a fila de votações comuns.
- **GameFi** — processamento de ações em massa, priorizando jogadores ou transações críticas.
- **Protocolos de mensagens** — entrega ordenada por urgência em sistemas de comunicação descentralizados.

<img width="1440" height="1128" alt="image" src="https://github.com/user-attachments/assets/51b56db5-6cf8-4181-894c-4cf25f6d662d" />

