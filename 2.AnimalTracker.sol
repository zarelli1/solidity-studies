// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

contract AnimalTracker {

    // 1. Criamos a estrutura (o modelo)
    struct Animal {
        string name;
    }

    // 2. Criamos a lista dinâmica
    Animal[] public listaAnimais;

    // 3. Adicionando os 3 animais manualmente (via lógica de estado)
    // Nota: Variáveis soltas não entram na lista sozinhas. 
    // Para fins de estudo, vamos usar uma função para popular a lista.
    
    function popularListaInicial() public {
        // Só adiciona se a lista estiver vazia para não repetir
        if (listaAnimais.length == 0) {
            listaAnimais.push(Animal("Leao"));
            listaAnimais.push(Animal("Dino"));
            listaAnimais.push(Animal("Cachorro"));
        }
    }

    // 4. Função para o usuário adicionar quantos quiser
    function addAnimal(string memory _name) public {
        listaAnimais.push(Animal(_name));
    }

    // 5. Função para visualizar um animal específico pelo índice
    function getAnimal(uint256 _index) public view returns (string memory) {
        return listaAnimais[_index].name;
    }
}
